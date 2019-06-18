# GPG signing fix
set -g -x GPG_TTY (tty)

# Start X, so launch bspwm
if status is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx -- -keeptty
    end
end
