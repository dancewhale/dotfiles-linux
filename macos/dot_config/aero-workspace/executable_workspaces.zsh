# ~/.config/aero-workspace/workspaces.zsh
#
# Logical workspace registry used by aero-workspace / Alfred.
#
# Physical workspace pool:
#   main monitor:      1 2 3 4 5
#   secondary monitor: q w e r t
#
# Add or change task workspaces only in the `workspace ...` declarations
# at the bottom of this file.
#
# Fields:
#   key       Alfred/internal canonical name
#   id        AeroSpace workspace ID
#   title     Alfred display name
#   layout    initial workspace root layout
#   bundle    dedicated app bundle ID
#   route     1 = route new app windows to this workspace
#   launch    1 = activate/launch app when switching here
#   aliases   Alfred search aliases

# ---------------------------------------------------------------------------
# Registry storage
# ---------------------------------------------------------------------------

typeset -ga WS_ORDER
typeset -gA WS_ID
typeset -gA WS_TITLE
typeset -gA WS_LAYOUT
typeset -gA WS_BUNDLE
typeset -gA WS_ROUTE
typeset -gA WS_LAUNCH
typeset -gA WS_ALIASES

WS_ORDER=()
WS_ID=()
WS_TITLE=()
WS_LAYOUT=()
WS_BUNDLE=()
WS_ROUTE=()
WS_LAUNCH=()
WS_ALIASES=()

# ---------------------------------------------------------------------------
# Registration helper
#
# Usage:
#   workspace key id title layout bundle route launch aliases
# ---------------------------------------------------------------------------

workspace() {
    local key="$1"
    local id="$2"
    local title="$3"
    local layout="$4"
    local bundle="$5"
    local route="$6"
    local launch="$7"
    local aliases="$8"

    WS_ORDER+=("$key")
    WS_ID[$key]="$id"
    WS_TITLE[$key]="$title"
    WS_LAYOUT[$key]="$layout"
    WS_BUNDLE[$key]="$bundle"
    WS_ROUTE[$key]="$route"
    WS_LAUNCH[$key]="$launch"
    WS_ALIASES[$key]="$aliases"
}

# ---------------------------------------------------------------------------
# Task workspaces
#
# Current mapping:
#   Day One  -> 1  (main)
#   Code     -> 2  (main)
#   Research -> q  (secondary)
#   Plan     -> w  (secondary)
#
# Slots 3/4/5 and e/r/t remain available for future tasks.
# ---------------------------------------------------------------------------

workspace dayone   1 'Day One'  h_accordion 'com.bloombuilt.dayone-mac'      1 1 'journal diary write j'
workspace code     2 'Code'     h_tiles     'com.todesktop.230313mzl4w4u92' 1 1 'dev coding cursor c'
workspace research q 'Research' h_accordion ''                               0 0 'research read web browser'
workspace plan     w 'Plan'     h_tiles     ''                               0 0 'plan planning task p'
