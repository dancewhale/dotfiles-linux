#!/bin/bash

main() {
    update-system
    install-packages
    install-yay
    set-user-groups
    enable-services
}

update-system() {
    sudo pacman --noconfirm -Syu
}

install-packages() {
    # yaylist
    printf '%b%s%b\n' "${FX_BOLD}${FG_CYAN}" "Starting Packages Installation from yaylist..."
    yay -S --needed $(cat ${PWD}/yaylist)
    printf '%b%s%b\n' "${FX_BOLD}${FG_GREEN}" "Installation of packages from yaylist has finished succesfully."

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

enable-services() {
    local services=(
    )

    local users=(
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

main "$@"
