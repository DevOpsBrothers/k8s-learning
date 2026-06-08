# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
        for rc in ~/.bashrc.d/*; do
                if [ -f "$rc" ]; then
                        . "$rc"
                fi
        done
fi

unset rc

# ==========================================
# GARUDA-INSPIRED NEON CYBERPUNK PROMPT (PS1)
# ==========================================
# Define ANSI Color Codes
G_PURPLE="\[\033[01;35m\]"
G_CYAN="\[\033[01;36m\]"
G_GREEN="\[\033[01;32m\]"
G_RED="\[\033[01;31m\]"
G_YELLOW="\[\033[01;33m\]"
G_RESET="\[\033[00m\]"

# Safe Git tracking helper function
_git_prompt() {
    local branch
    if branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null); then
        echo -e " ${G_PURPLE}on ${G_RED}� ${branch}${G_RESET}"
    fi
}

# Multi-line structural layout
# ┌─[user@host]─[directory] [git-branch]
# └──❯
export PS1="${G_PURPLE}┌─[${G_CYAN}\u@\h${G_PURPLE}]─[${G_GREEN}\w${G_PURPLE}]\$(_git_prompt)\n${G_PURPLE}└──❯${G_RESET} "

eval "$(starship init bash)"

# ==========================================
# KUBECTL AUTOCOMPLETE & SHORTCUTS
# ==========================================
# Ensure core bash-completion is loaded
if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi

# Enable native kubectl completion
source <(kubectl completion bash)

# Setup short alias 'k' with full autocomplete mapping
alias k='kubectl'
complete -o default -F __start_kubectl k

# Fast namespace switching shortcut
alias kn='kubectl config set-context --current --namespace'

# ==========================================
# HELM AUTOCOMPLETE & SHORTCUTS
# ==========================================
if command -v helm &> /dev/null; then
    source <(helm completion bash)
    alias h='helm'
    complete -o default -F __start_helm h
fi