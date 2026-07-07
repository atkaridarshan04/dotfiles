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


# Start Starship

eval "$(starship init zsh)"
