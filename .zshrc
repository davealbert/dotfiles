DEFAULT_USER=dave
# Path to your oh-my-zsh installation.
export ZSH=/Users/davealbert/.oh-my-zsh
bindkey \^U backward-kill-line
export ZSH=/Users/dave/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="random"
#ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker vagrant aws kubectl)

# User configuration

export PATH="/usr/local/bin:/Users/dave/.rvm/gems/ruby-2.2.0/bin:/Users/dave/.rvm/gems/ruby-2.2.0@global/bin:/Users/dave/.rvm/rubies/ruby-2.2.0/bin:/opt/local/bin:/opt/local/sbin:/usr/bin:/opt/local/bin:/opt/local/sbin:/Applications/MAMP/bin/php5/bin:/opt/local/bin:/opt/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/local/sbin:/usr/local/mysql/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/Users/dave/scripts:/usr/bin:/bin:/usr/sbin:/sbin:/Users/dave/.rvm/rubies/ruby-2.2.0/bin:/opt/local/bin:/opt/local/sbin:/Applications/MAMP/bin/php5/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/X11/bin:/Users/dave/scripts:/usr/local/Cellar/binutils/2.23/bin:/Users/dave/.rvm/bin:/usr/local/Cellar/binutils/2.23/bin:/usr/local/go/bin"

source $ZSH/oh-my-zsh.sh

function cdd {
   if [[ "x$1" != "x" ]]; then
      cd $1;
   fi;
   cd $(pwd -P)
}


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
#alias vim='mvim -v'

# Git aliases
alias ba='git branch;git branch --list -a|grep "remotes/origin" --colour=never'
alias co='git checkout'
alias gitx='open -a GitX .'
alias s='git status'
alias l="ls -lthr"
alias mux='tmuxinator'
alias lynx='/Applications/Lynxlet.app/Contents/Resources/lynx/bin/lynx'
alias vim="vim -S ~/.vimrc"
alias now="date -u +\"%Y%m%dT%H%M%S\""
alias ts="date -u +\"%Y%m%dT%H%M%S\""
alias dad='curl -H "User-Agent: Dad Nerd Curl" -H "Accept: application/json" https://icanhazdadjoke.com/'

function mdless() {
    pandoc -s -f markdown -t man $1 | groff -T utf8 -man | less
}

_umcomplete() {
    complete -W "$(umls| tr '\n' ' ')" $1
}

umls() { ls -1 ~/Dropbox/.notes/"$1"; }
_umcomplete umls

umedit() { mkdir -p ~/Dropbox/.notes; vim ~/Dropbox/.notes/$1; }
_umcomplete umedit

um() { if [[ "$1x" == "x" ]];then umls;else cat ~/Dropbox/.notes/"$1";fi }
_umcomplete um

umless() { mdless ~/Dropbox/.notes/"$1"; }
_umcomplete umless

umcat() { cat ~/Dropbox/.notes/"$1"; }
_umcomplete umcat

umgrep() { grep $1 ~/Dropbox/.notes/* -d skip ; }

alias yt='mpsyt'
#function play() { /Applications/VLC.app/Contents/MacOS/VLC --intf rc "$1" -R }
function play {
    while getopts s: option
    do
        case "${option}"
            in
            s) SPEED=\-\-speed\ ${OPTARG}
               shift;shift
        esac
    done

    set -x
    mpv --no-video --loop-playlist $(echo $SPEED) "$1"
    unset SPEED
}

function tron() {
    play ~/Google\ Drive/Music/tron-server-room-programming-3.mp3
}

# Kubernetes aliases
#alias prodkube='az acs kubernetes get-credentials -g medit-acs-rg -n medit-acs'
#alias testkube='az aks get-credentials  -g medit-test -n aks-medit-test'
alias kwhich='kubectl config current-context'
alias kwatch='watch "kubectl get nodes &&echo && kubectl get pods -o wide && echo && kubectl get svc && echo && kubectl get cs && echo && kubectl get storageclass && echo && kubectl get deployments"'
alias k='kubectl'
alias kg='kubectl get'
function kbrowse() {
    if [[ "${1}x" == "x" ]];
    then
        echo "Usage: kbrowse [prod|test]"
        return
    fi
    az acs kubernetes browse -g ${1}-medit-acs-rg -n ${1}-medit-acs --ssh-key-file ~/.ssh/az_k8s_rsa
}

function kshow() {
    kubectl get nodes &&echo && kubectl get pods -o wide && echo && kubectl get svc && echo && kubectl get cs && echo && kubectl get storageclass && echo && kubectl get deployments
}

function kswitchacs () {
    az acs kubernetes get-credentials -g ${1}-medit-acs-rg -n ${1}-medit-acs --ssh-key-file ~/.ssh/az_k8s_rsa
}

function kswitchaks () {
    kubectl config use-context medit-aks-${1}
}

function st () { open -a SourceTree $(git rev-parse --show-toplevel) }
function vs () { open -a /Applications/Visual\ Studio\ Code.app $(pwd) }


function ss () {
   CMD="${@:2}"
   LIST=$(ack $1 /Users/davealbert/code/_One15Digital/sysAdmin/ansible/hosts|grep -v "^#" |uniq)
   LINES=$(echo ${LIST}|wc -l)
   if [[ $LINES > 1 ]];
   then
      echo $LIST
   else;
      if [[ "${CMD}x" == "x" ]];
      then
         ssh dave@$(echo $LIST|cut -d"=" -f 4) -p5353
      else
         ssh dave@$(echo $LIST|cut -d"=" -f 4) -p5353 $CMD
      fi;
   fi
}


jira() {
    URL='https://one15digital.atlassian.net/browse/'
    echo "Opening: ${URL}${1}"
    open "${URL}${1}"
}

focus () {
        echo -n "What is your intention? "
        read INTENTION
        START=$(date)
        clear
        echo $START
        cat ~/focus.txt
        input="x"
        if [[ "x$1" = "x" ]]
        then
                TIME=1500
        else
                TIME=$(( $1 * 60 ))
        fi
        STAGE=$(( $TIME / 2 ))
        for I in {1..$TIME}
        do
                #MOD=$(( $I % $STAGE ))
                #if [[ $MOD == 0 ]];
                #then
                    #if [[ $I != $TIME ]];
                    #then
                        #say tick toc $I of $TIME
                    #fi
                #fi

                if [[ $input != "x" ]]
                then
                        clear
                        echo $START
                        cat ~/focus.txt
                        echo $I of $TIME
                        echo $STAGE
                        printf "%0.2f minutes remaining\n" $(( ($TIME - $I) / 60.0 ))
                        printf "Are you moving towards:  '%s'\n" $INTENTION
                        input="x"
                        sleep 0.75
                fi
                read -t 1 input
        done
        echo $START
        date
        say "hey yo hey yo hey yo hey yo hey yo hey yo"
        say times up. take a minute. ree focus.
}

function tweet {
    if [[ "$*x" == "x" ]];
    then
        echo Usage: $0 \"Status message\"
        return
    fi
    FILENAME=old-skool-twitter.txt
    TMPFILE=tweet.tmp
    LINENUM=18
    pushd ~/code/davealbert.github.io/textfiles
    head -n $LINENUM $FILENAME > $TMPFILE
    date >> $TMPFILE
    echo "- $*" >> $TMPFILE
    tail -n +$LINENUM $FILENAME >> $TMPFILE
    cat $TMPFILE > $FILENAME
    git add $FILENAME
    git commit -m "OSK-Tweet: $*"
    git push
    rm $TMPFILE
}

function t {
    if [[ "$*x" == "x" ]];
    then
        echo Usage: $0 \"Status message\"
        return
    fi

    perl ~/code/oysttyer/oysttyer.pl -status="$*"
    tweet "$*"
  }

function ks {
    testadmin="medit-aks-test-admin"
    testaks="medit-aks-test"
    prodacs="prod-medit-prod-medit-acs-r-8dfff2mgmt"
    testacs="test-medit-test-medit-acs-r-8dfff2mgmt"

    CHOICE=$1$2
    if [[ "${(P)CHOICE}x" == "x" ]];
    then
        echo Bad Selection
        echo
        echo try: ks test aks
        return 1
    fi
    echo kubectl config use-context ${(P)CHOICE}
    kubectl config use-context ${(P)CHOICE}
}

function koan {
    if [[ "x" == "x${1}" ]];
    then
        NUM=$(( ( RANDOM % 101 )  + 1 ))
    else
        NUM=$1
    fi;
    KOAN=$(ls -1 ~/koan|grep -e "^${NUM}[a-z]")
    elinks -dump ~/koan/${KOAN}|less
}

function v() { vim -c "cd $1" -c "pwd" }

# Duck Duck Go
function ddg {
    Q=$(node -e "console.log(encodeURIComponent('$*'))")
    w3m https://duckduckgo.com/\?q\=$Q
}

function calc { echo "$*" |bc}

function funnel() {
    INSTALLS="$1"
    DIR="/Users/dave/OneDrive - One15/Medit/Analytics"
    NOW="$(now)"
    FILENAME="${DIR}/arch/${NOW}.txt"
    ${DIR}/funnel.sh ${INSTALLS} > ${FILENAME}
    cat $FILENAME | pbcopy
    echo $FILENAME
    say "funnel done"
 }

function cms() {
    if  [[ "xx" == "xx${1}" ]];
    then
        echo "invalid command : $0 1 exec"
        return;
    fi
    _CMS=($(kubectl.docker get pods |grep cms-medit|cut -f 1 -d" "));
    _LOGS="kubectl.docker logs -f --tail=10 $_CMS[$1]"
    _EXEC="kubectl.docker exec -it $_CMS[$1] bash"
    if [[ "xx" == "xx${2}" ]];
    then
        echo "invalid command type (log, exec)"
        return;
    fi

    if [[ "log" == "${2}" ]];
    then
        _CMD=$_LOGS
    fi

    if [[ "exec" == "${2}" ]];
    then
        _CMD=$_EXEC
    fi

    echo $_CMD
    eval $_CMD
}


#alias KeeLocal='echo -n ~/code/KeePass/local.key|pbcopy && open -n /Applications/KeePassX.app ~/code/KeePass/local.kdb'

DISABLE_AUTO_TITLE=true
export EDITOR='vim'

export GOPATH="/Users/davealbert/code/_Training/go"

export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_74.jdk/Contents/Home"
export EC2_HOME=/usr/local/ec2/ec2-api-tools-1.7.5.1/
export PATH=$PATH:$EC2_HOME/bin
export PATH="$HOME/.fastlane/bin:$PATH"

# Azure-cli (az) tab completion
autoload bashcompinit && bashcompinit
eval "$(register-python-argcomplete az)"

# Helm tab completion
source <(helm completion zsh)

export PATH="$HOME/.fastlane/bin:$PATH:/Users/dave/.gem/ruby/2.0.0/bin"

function hal {
    cd "/Users/davealbert/Google Drive/hal"
    node app
}
