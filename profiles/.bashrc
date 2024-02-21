function cls {
    clear;
}

function scoop() {
    powershell -ex unrestricted scoop "$@" ;
} && export -f scoop

export editor="code"
export termem="alacritty"

eval "$(starship init bash)"