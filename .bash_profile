# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

alias ll='ls -lrth'
alias l='ls -lrth'
alias la='ls -lrtha'
alias l1='ls -1'

alias dsort='du -sh *|sort -hr'


# Function to get the current git branch (returns empty if not in a git repo)
parse_git_branch() {
    git branch 2>/dev/null | grep '^*' | colrm 1 2
}

# 2. Add this line to export it to all sub-shells!
export -f parse_git_branch

# Constructing the colorful PS1 prompt
# Yellow: \e[33m | Cyan: \e[36m | Purple: \e[35m | Reset: \e[0m
export PS1="[ \[\e[33m\]\u\[\e[0m\]@\[\e[36m\]\h\[\e[0m\]: \[\e[35m\]\w\[\e[0m\] ] \$(br=\$(parse_git_branch); if [ -n \"\$br\" ]; then echo \"[ \[\e[32m\]\$br\[\e[0m\] ] \"; fi)\n[ \[\e[36m\]\d\[\e[0m\] | \[\e[33m\]\t\[\e[0m\] ] \$ "