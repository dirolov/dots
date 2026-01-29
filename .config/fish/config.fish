if status is-interactive
    # Commands to run in interactive sessions can go here
end

export VISUAL=micro
export EDITOR=micro
export MANOPT="-L ru"
export MANPAGER=most

source ~/.config/fish/functions/promptbak.fish
cat ~/.cache/wal/sequences

alias sudo=doas
alias add="doas pacman -S"
alias u="doas pacman -Syu"
alias purge="doas pacman -Rns"
alias pm="pacman"
alias q=exit
alias c=clear
alias lah="lsd -lah"
alias nano=micro
alias l="lsd -l"
alias lah="lsd -lah"
alias ls=lsd
alias addmus='yt-dlp -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata --no-write-info-json --no-write-thumbnail --rm-cache-dir -o "%(title)s.%(ext)s"'
alias m=micro
alias gcl="git clone --depth 1"
