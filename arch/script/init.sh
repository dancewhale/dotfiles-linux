#!/bin/bash

main() {
    init-constants
    update-system
    install-paru
    install-packages
    install-go-packages
    set-user-groups
    enable-services
    set-leftovers
    post-install-message
}

init-constants() {
    FX_RESET="\033[0m"
    FX_BOLD="\033[1m"
    FX_ITALIC="\033[3m"

    FG_RED="\033[31m"
    FG_GREEN="\033[32m"
    FG_YELLOW="\033[33m"
    FG_CYAN="\033[36m"
    FG_WHITE="\033[37m"

    BG_MAGENTA="\033[45m"

    # ERROR
    #printf '%b%s%b\n' "${FX_BOLD}${FG_RED}"
    # WARN
    #printf '%b%s%b\n' "${FX_BOLD}${FG_YELLOW}"
    # SUCESSFUL
    #printf '%b%s%b\n' "${FX_BOLD}${FG_GREEN}"
    # INFO
    #printf '%b%s%b\n' "${FX_BOLD}${FG_CYAN}"
}

update-system() {
    sudo pacman --noconfirm -Syu
}

install-paru() {
    # Install required dependencies
    sudo pacman -S --noconfirm git ccache

    mkdir -p ~/cache
    # Install paru package manager from AUR
    git clone https://aur.archlinux.org/paru.git ~/cache/paru || true
    pushd ~/cache/paru
    makepkg --noconfirm -si

    # Clean up unused dependencies
    sudo pacman -Rns --noconfirm $(pacman -Qdtq)

    # Check if paru is installed
    if paru --version &>/dev/null; then
        printf '%b%s%b\n' "${FX_BOLD}${FG_GREEN}" "paru package manager installed successfully."
    else
        printf '%b%s%b\n' "${FX_BOLD}${FG_RED}" "Installation of paru package manager failed."
    fi
    popd
}

install-packages() {
    # Start packages installation - paclist
    printf '%b%s%b\n' "${FX_BOLD}${FG_CYAN}" "Starting Packages Installation from paclist..."
    sudo pacman -S --needed $(cat ${PWD}/paclist)
    printf '%b%s%b\n' "${FX_BOLD}${FG_GREEN}" "Installation of packages from paclist has finished succesfully."
    # parulist
    printf '%b%s%b\n' "${FX_BOLD}${FG_CYAN}" "Starting Packages Installation from parulist..."
    paru -S --needed $(cat ${PWD}/parulist)
    printf '%b%s%b\n' "${FX_BOLD}${FG_GREEN}" "Installation of packages from parulist has finished succesfully."

    # Installing plugins for nnn file manager if not installled
    printf '%b%s%b\n' "${FX_BOLD}${FG_CYAN}" "Installing plugins for nnn file manager..."
    plugins_dir="$HOME/.config/nnn/plugins"

    if [ -z "$(ls -A "$plugins_dir")" ]; then
        printf '%b%s%b\n' "${FX_BOLD}${FG_CYAN}" "Fetching nnn plugins..."

        sh -c "$(curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs)"

        printf '%b%s%b\n' "${FX_BOLD}${FG_GREEN}" "Plugins for nnn file manager installed succesfully."
    else
        printf '%b%s%b\n' "${FX_BOLD}${FG_RED}" "nnn plugins directory is not empty."
    fi

    # Clone SecLists repo if does not exist
    payloads_dir="/usr/share/payloads"
    seclists_dir="$payloads_dir/SecLists"

    if [ ! -d "$payloads_dir" ] || [ ! -d "$seclists_dir" ]; then
        printf '%b%s%b\n' "${FX_BOLD}${FG_CYAN}" "Creating directories and cloning SecLists repository..."

        sudo mkdir -p "$payloads_dir"
        sudo git clone https://github.com/danielmiessler/SecLists.git "$seclists_dir"

        printf '%b%s%b\n' "${FX_BOLD}${FG_GREEN}" "SecLists repository cloned to $seclists_dir."
    else
        printf '%b%s%b\n' "${FX_BOLD}${FG_YELLOW}" "SecLists repository already exists in $seclists_dir."
    fi

    # Zsh as default shell
    default_shell=$(getent passwd "$(whoami)" | cut -d: -f7)
    if [ "$default_shell" != "$(which zsh)" ]; then
        printf '%b%s%b\n' "${FX_BOLD}${FG_CYAN}" "Zsh is not the default shell. Changing shell..."
        sudo chsh -s "$(which zsh)" "$(whoami)"
        printf '%b%s%b\n' "${FX_BOLD}${FG_GREEN}" "Shell changed to Zsh."
    else
        printf '%b%s%b\n' "${FX_BOLD}${FG_YELLOW}" "Zsh is already the default shell."
    fi

    # Export default PATH to zsh config
    zshenv_file="/etc/zsh/zshenv"
    line_to_append="export ZDOTDIR=$HOME/.config/zsh"

    if [ ! -f "$zshenv_file" ]; then
        printf '%b%s%b\n' "${FX_BOLD}${FG_CYAN}" "Creating $zshenv_file..."
        echo "$line_to_append" | sudo tee "$zshenv_file" >/dev/null
        printf '%b%s%b\n' "${FX_BOLD}${FG_GREEN}" "$zshenv_file created."
    else
        printf '%b%s%b\n' "${FX_BOLD}${FG_YELLOW}" "$zshenv_file already exists."
    fi

    # Setting ficti5
    imsettings-switch fcitx5
    sudo alternatives --config xinputrc
    sudo grep "fcitx5" /etc/environment ||
        echo 'INPUT_METHOD=fcitx5
GTK_IM_MODULE=fcitx5
QT_IM_MODULE=fcitx5
XMODIFIERS=@im=fcitx5' | sudo tee -a /etc/environment

}

set-user-groups() {
    # Razer, audit and sddm autologin group
    add_groups=(
        plugdev
        audit
        autologin
    )

    for group in "${add_groups[@]}"; do
        if ! getent group "$group" >/dev/null; then
            printf '%b%s%b\n' "${FX_BOLD}${FG_CYAN}" "Creating group '$group'..."
            sudo groupadd "$group"
        else
            printf '%b%s%b\n' "${FX_BOLD}${FG_YELLOW}" "Group '$group' already exists."
        fi
    done

    # Libvirtd groups (for virt-manager)
    usermod_groups=(
        libvirt
        libvirt-qemu
        kvm
        input
        disk
        docker
    )

    gpasswd_groups=(
        audit
        autologin
        plugdev
        mpd
        docker
    )

    username="$(whoami)"

    # Adding user to groups using usermod
    for group in "${usermod_groups[@]}"; do
        if ! groups "$username" | grep -q "\<$group\>"; then
            printf '%b%s%b\n' "${FX_BOLD}${FG_CYAN}" "Adding user '$username' to group '$group'..."
            sudo usermod -aG "$group" "$username"
        else
            printf '%b%s%b\n' "${FX_BOLD}${FG_YELLOW}" "User '$username' is already a member of group '$group'."
        fi
    done

    # Adding user to groups using gpasswd
    for group in "${gpasswd_groups[@]}"; do
        if ! groups "$username" | grep -q "\<$group\>"; then
            printf '%b%s%b\n' "${FX_BOLD}${FG_CYAN}" "Adding user '$username' to group '$group'..."
            sudo gpasswd -a "$username" "$group"
            sudo chmod 710 "/home/$(whoami)" # needed for mpd group
        else
            printf '%b%s%b\n' "${FX_BOLD}${FG_YELLOW}" "User '$username' is already a member of group '$group'."
        fi
    done
}

install-go-packages() {
    go install github.com/acroca/go-symbols@latest
    go install github.com/cweill/gotests/gotests@latest
    go install github.com/fatih/gomodifytags@main
    go install github.com/josharian/impl@latest
    go install github.com/ramya-rao-a/go-outline@latest
    go install github.com/rogpeppe/godef@latest
    go install github.com/sqs/goreturns@latest
    go install github.com/nsf/gocode@latest
    go install github.com/x-motemen/gore/cmd/gore@latest
    go install golang.org/x/tools/cmd/goimports@latest
    go install golang.org/x/lint/golint@latest
    go install golang.org/x/tools/cmd/gorename@latest
    go install golang.org/x/tools/cmd/guru@latest
    go install golang.org/x/tools/gopls@latest
    go install github.com/go-delve/delve/cmd/dlv@latest
}

enable-services() {
    local services=(
        sddm
        docker
        clash-meta
    )

    local users=(
        waynergy
        seafile
    )

    # Enable services if they exist and are not enabled
    for service in "${services[@]}"; do
        if systemctl list-unit-files --type=service | grep -q "^$service.service"; then
            if ! systemctl is-enabled --quiet "$service"; then
                printf '%b%s%b\n' "${FX_BOLD}${FG_CYAN}" "Enabling service: $service..."
                sudo systemctl enable "$service"
            else
                printf '%b%s%b\n' "${FX_BOLD}${FG_YELLOW}" "Service already enabled:\n" "$service"
            fi
        else
            printf '%b%s%b\n' "${FX_BOLD}${FG_RED}" "Service does not exist:\n" "$service"
        fi
    done

    # Enable users service as user if service exists and is not enabled
    for service in "${user[@]}"; do
        if systemctl list-unit-files --user --type=service | grep -q "^$users.service"; then
            if ! systemctl --user is-enabled --quiet "$service"; then
                printf '%b%s%b\n' "${FX_BOLD}${FG_CYAN}" "Enabling service: \"$service..."
                systemctl --user enable "$service"
            else
                printf '%b%s%b\n' "${FX_BOLD}${FG_YELLOW}" "Service already enabled:\n" "$service."
            fi
        else
            printf '%b%s%b\n' "${FX_BOLD}${FG_RED}" "Service does not exist:" "$service."
        fi
    done

    # Call the check_enabled_services function and pass the services array as an argument
    check-results "${services[@]}"

    # Other services
    hblock # block ads and malware domains
    #playerctld daemon                   # if it doesn't work try installing volumectl
}

set-leftovers() {
    # Disable the systemd-boot startup entry if systemd-boot is installed
    if [ -d "/sys/firmware/efi/efivars" ] && [ -d "/boot/loader" ]; then
        printf '%b%s%b\n' "${FX_BOLD}${FG_CYAN}" "Disabling systemd-boot startup entry"
        sudo sed -i 's/^timeout/# timeout/' /boot/loader/loader.conf
        printf '%b%s%b\n' "${FX_BOLD}${FG_GREEN}" "Disabled systemd-boot startup entry"
    else
        printf '%b%s%b\n' "${FX_BOLD}${FG_CYAN}" "systemd-boot is not being used."
    fi

    # Set data locale english if it is not set
    if [[ "$(localectl status)" != *"LC_TIME=en_US.UTF8"* ]]; then
        printf '%b%s%b\n' "${FX_BOLD}${FG_CYAN}" "Setting LC_TIME to English..."
        sudo localectl set-locale LC_TIME=en_US.UTF8
        printf '%b%s%b\n' "${FX_BOLD}${FG_GREEN}" "LC_TIME set to English."
    else
        printf '%b%s%b\n' "${FX_BOLD}${FG_YELLOW}" "LC_TIME is already set to English."
    fi

    # Install GRUB theme if GRUB is installed
    if command -v grub-install >/dev/null && ! command -v bootctl >/dev/null; then
        printf '%b%s%b\n' "${FX_BOLD}${FG_CYAN}" "Installing GRUB theme..."

        # Clone theme repository
        git clone https://github.com/HenriqueLopes42/themeGrub.CyberEXS
        mv themeGrub.CyberEXS CyberEXS

        # Move theme directory to GRUB themes directory
        sudo mv CyberEXS /boot/grub/themes/

        # Update GRUB configuration
        sudo grub-mkconfig -o /boot/grub/grub.cfg

        # Set GRUB theme in GRUB configuration
        echo 'GRUB_THEME=/boot/grub/themes/CyberEXS/theme.txt' | sudo tee -a /etc/default/grub

        printf '%b%s%b\n' "${FX_BOLD}${FG_GREEN}" "GRUB theme installed."
    else
        printf '%b%s%b\n' "${FX_BOLD}${FG_CYAN}" "GRUB bootloader is not installed, using systemd-boot."
    fi

    # Create Hyprland desktop entry if Hyprland is installed
    if command -v Hyprland >/dev/null; then
        printf '%b%s%b\n' "${FX_BOLD}${FG_CYAN}" "Creating Hyprland desktop entry..."

        sudo bash -c "cat <<EOF > /usr/share/wayland-sessions/hyprland.desktop
[Desktop Entry]
Name=Hyprland
Comment=hyprland
Exec=bash -c \"$HOME/.config/hypr/scripts/starth\"
Type=Application
"

        printf '%b%s%b\n' "${FX_BOLD}${FG_GREEN}" "Hyprland desktop entry created."
    else
        printf '%b%s%b\n' "${FX_BOLD}${FG_RED}" "Hyprland is not installed."
    fi

    # SDDM rice (don't install GDM cuz it installs GNOME DE as dependency)
    if command -v sddm >/dev/null; then
        printf '%b%s%b\n' "${FX_BOLD}${FG_CYAN}" "Creating /etc/sddm.conf file..."

        sudo bash -c 'cat <<EOF > /etc/sddm.conf
# Use autologin if have problems with sddm
#[Autologin]
#Session=hyprland
#User=twilight

[Theme]
Current=astronaut
CursorSize=24
CursorTheme=Numix-Cursor-Light
Font=JetBrains Mono
ThemeDir=/usr/share/sddm/themes
'

        printf '%b%s%b\n' "${FX_BOLD}${FG_GREEN}" "/etc/sddm.conf file created."
    else
        printf '%b%s%b\n' "${FX_BOLD}${FG_RED}" "SDDM is not installed."
    fi

    # Define the desired button layout value (remove buttons - none)
    desired_button_layout=":"

    # Get the current button layout value using gsettings
    current_button_layout=$(gsettings get org.gnome.desktop.wm.preferences button-layout)

    # Compare the current value with the desired value using an if statement
    if [ "$current_button_layout" != "$desired_button_layout" ]; then
        # If they don't match, update the button layout using the gsettings command
        gsettings set org.gnome.desktop.wm.preferences button-layout "$desired_button_layout"
        printf '%b%s%b\n' "${FX_BOLD}${FG_GREEN}" "Button layout has been updated."
    else
        # If they match, display a message indicating that the value is already as desired
        printf '%b%s%b\n' "${FX_BOLD}${FG_YELLOW}" "Button layout is already set as desired."
    fi
}

post-install-message() {
    printf '%b%s%b\n' "${FX_BOLD}${FG_GREEN}" "Post-Installation:"
    printf '%b%s%b\n' "${FX_BOLD}${FG_GREEN}" "Start setting seafile."
    # Setting seafile
    # 安装并启动seafile
    mkdir ~/Dropbox

    session=$(bw unlock | grep export)
    eval ${session:2}

    surl=$(echo '{{ (bitwardenFields "item" "b27f7204-9341-4396-804e-aff9002a478a").url.value }}' | chezmoi execute-template)
    suser=$(echo '{{ (bitwardenFields "item" "b27f7204-9341-4396-804e-aff9002a478a").user.value }}' | chezmoi execute-template)
    spass=$(echo '{{ (bitwardenFields "item" "b27f7204-9341-4396-804e-aff9002a478a").password.value }}' | chezmoi execute-template)

    seaf-cli status | grep Dropbox || seaf-cli sync -l "3440279a-fd36-4e94-bc0e-d3da402a1e58" -s $surl -d ~/Dropbox -u $suser -p $spass

}

main "$@"
