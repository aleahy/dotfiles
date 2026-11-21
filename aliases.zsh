# Shortcuts
alias copyssh="pbcopy < $HOME/.ssh/id_rsa.pub"
alias reloadcli="source $HOME/.zshrc"
#alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
#alias ll="/usr/local/opt/coreutils/libexec/gnubin/ls -ahlF --color --group-directories-first"
#weather() { curl -4 wttr.in/${1:-antwerp} }
#alias phpstorm='open -a /Applications/PhpStorm.app "`pwd`"'
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias c="clear"
#alias zbundle="antibody bundle < $DOTFILES/zsh_plugins.txt > $DOTFILES/zsh_plugins.sh"

# Directories
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"
alias sites="cd $HOME/Sites"

# Laravel
alias a="php artisan"
alias ams="php artisan migrate:fresh --seed"
alias idehelper="php artisan clear-compiled && php artisan ide-helper:generate && php artisan ide-helper:models --nowrite && php artisan ide-helper:meta"
alias atp="php artisan test --parallel"

# PHP
alias cfresh="rm -rf vendor/ composer.lock && composer i"
alias creset="rm -rf vendor && composer i"

# JS
alias nfresh="rm -rf node_modules/ package-lock.json && npm install"
alias nreset="rm -rf node_modules && npm install"
alias ndev="npm run dev"
alias nbuild="npm run build"
alias nprod="npm run build"
alias nin="npm install"
alias nup="npm update"


# Docker
#alias docker-composer="docker-compose"
#alias dstop="docker stop $(docker ps -a -q)"
#alias dpurgecontainers="dstop && docker rm $(docker ps -a -q)"
#alias dpurgeimages="docker rmi $(docker images -q)"
#dbuild() { docker build -t=$1 .; }
#dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }

# Git
alias commit="git add . && git commit -m"
alias gcommit="git add . && git commit"
alias amend="git commit --amend --no-edit"
alias amendall="git add . && amend"
alias wip="commit wip"
alias gst="git status"
alias gb="git branch"
alias gc="git checkout"
alias gd="git diff"
alias resolve="git add . && git commit --no-edit"
alias gl="git log --oneline --decorate --color"
alias nuke="git clean -df && git reset --hard"
alias undo_commit="git reset --soft HEAD~1"

#1Password CLI
#alias aws="op run --env-file=$HOME/.config/op/aws-env -- aws"

#Networking
alias myip="curl -4 ifconfig.me"

