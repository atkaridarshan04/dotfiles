# Detect OS

if [[ "$OSTYPE" == "darwin"* ]]; then
    export STARSHIP_DISTRO=""

    MODEL=$(sysctl -n hw.model 2>/dev/null)

    case "$MODEL" in
        MacBook*)
            export STARSHIP_DEVICE=""
            ;;
        *)
            export STARSHIP_DEVICE=""
            ;;
    esac

elif [[ "$OSTYPE" == "linux-gnu"* ]]; then

    DISTRO=$(awk -F= '/^ID=/{print $2}' /etc/os-release 2>/dev/null)

    case "$DISTRO" in
        arch)
            export STARSHIP_DISTRO=""
            ;;
        ubuntu)
            export STARSHIP_DISTRO=""
            ;;
        debian)
            export STARSHIP_DISTRO=""
            ;;
        fedora)
            export STARSHIP_DISTRO=""
            ;;
        nixos)
            export STARSHIP_DISTRO=""
            ;;
        *)
            export STARSHIP_DISTRO=""
            ;;
    esac

fi


# NOTE: starship is initialised in .zshrc, not here.
# It used to be `eval "$(starship init zsh)"` at the bottom of this file as well, which ran
# the init twice per shell -- once from this file and once from .zshrc -- doubling the
# startup cost and installing the precmd/preexec hooks twice. The exports above must still
# happen before init, which .zshrc guarantees: it sources every ~/.zsh/*.zsh first, then inits.
