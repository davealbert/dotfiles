DEFAULT_USER=davealbert
# Path to your oh-my-zsh installation.
export ZSH=/Users/davealbert/.oh-my-zsh
bindkey \^U backward-kill-line

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
plugins=(git chucknorris z docker vagrant tmuxinator fabric aws )

# User configuration

export PATH="/Users/dave/.rvm/gems/ruby-2.2.0/bin:/Users/dave/.rvm/gems/ruby-2.2.0@global/bin:/Users/dave/.rvm/rubies/ruby-2.2.0/bin:/opt/local/bin:/opt/local/sbin:/usr/bin:/opt/local/bin:/opt/local/sbin:/Applications/MAMP/bin/php5/bin:/opt/local/bin:/opt/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/Users/dave/scripts:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/Users/dave/.rvm/gems/ruby-2.2.0/bin:/Users/dave/.rvm/gems/ruby-2.2.0@global/bin:/Users/dave/.rvm/rubies/ruby-2.2.0/bin:/opt/local/bin:/opt/local/sbin:/Applications/MAMP/bin/php5/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/X11/bin:/Users/dave/scripts:/usr/local/Cellar/binutils/2.23/bin:/Users/dave/.rvm/bin:/usr/local/Cellar/binutils/2.23/bin:/usr/local/go/bin"
#
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
autoload ztodo

function cdd {
   if [[ "x$1" != "x" ]]; then
      cd $1;
   fi;
   cd $(pwd -P)
}


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
#alias vim='mvim -v'

# Git aliases
alias co='git checkout'
alias gitx='open -a GitX .'
alias s='git status'
alias l="ls -lthr"
alias mux='tmuxinator'
alias lynx='/Applications/Lynxlet.app/Contents/Resources/lynx/bin/lynx'
alias vim="vim -S ~/.vimrc"
alias now="date -u +\"%Y%m%dT%H%M%S\""
alias ts="date -u +\"%Y%m%dT%H%M%S\""


function st () { open -a SourceTree $(git rev-parse --show-toplevel) }

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



function focus {
    clear
    cat ~/focus.txt
    input="x"
    if [[ "x$1" == "x" ]]
    then
        TIME=1500
    else
        TIME=$(( $1 * 60 ))
    fi
    for I in {1..$TIME}
    do
       if [[ $input != "x" ]]
       then
          clear
          cat ~/focus.txt
          echo $I of $TIME
          input="x"
       fi
       read -t 1 input #Any input will display status
    done
    say aaaaaaaaaaaaaaaaaaaaaaaaaa
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


#alias KeeLocal='echo -n ~/code/KeePass/local.key|pbcopy && open -n /Applications/KeePassX.app ~/code/KeePass/local.kdb'

DISABLE_AUTO_TITLE=true
export EDITOR='vim'


#chuck_cow

export GOPATH="/Users/davealbert/code/_Training/go"

export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_74.jdk/Contents/Home"
export EC2_HOME=/usr/local/ec2/ec2-api-tools-1.7.5.1/
export PATH=$PATH:$EC2_HOME/bin

