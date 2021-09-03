# Emoji
EMOJI="%{$fg_bold[white]%}\$(node $HOME/.oh-my-zsh/custom/themes/emoji.js)"
PROMPT="%(?:%{$fg_bold[green]%}➜"$EMOJI":%{$fg_bold[red]%}➜"$EMOJI")"
PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

function pstaskover {
  export PS_TASK_OVER="$(date +%H%M)"
  trap 'unset PS_TASK_OVER' SIGUSR1
  p=$$
  ( sleep 3600; kill -SIGUSR1 $p ) &
  # echo "export PS_TASK_OVER=""" | at now + 1 hour
  # touch /tmp/psanimatepid-$$
  # [ ! -z `cat /tmp/psanimatepid-$$` ] && psanimate `cat /tmp/psanimatesleep`
  psanimate_stop
  return 0
}

psanimate_stop() {
  touch /tmp/psanimatepid-$$
  PID=`cat /tmp/psanimatepid-$$`
  if [[ ! -z "$PID" ]]
    then
    (kill $PID > /dev/null 2>&1)
  fi
  rm /tmp/psanimatepid-$$
  return 0
}
echo "" > /tmp/psanimatesleep
psanimate() {
  SLEEP_TIMER=${1:-'1'}
  echo "$SLEEP_TIMER" > /tmp/psanimatesleep
  psanimate_stop
  _ps_emoji_animation() {
    S="\033[s"
    U="\033[u"
    SWITCH=1
    while [ : ]
    do
      SWITCH=$((1-SWITCH))
      EMOJI=`$HOME/.nvm/versions/node/v16.6.0/bin/node $HOME/.oh-my-zsh/custom/themes/emoji.js $SWITCH`
      LEN=${#EMOJI}
      POS="\033[1000D\033[0C"
      eval echo -ne '$S$POS$EMOJI$U'
      sleep $SLEEP_TIMER
    done
  }
  (_ps_emoji_animation & ; echo "$!" > /tmp/psanimatepid-$$)
  return 0
}

PS_AUTO_ANIMATE=0
(
  function _psautoanimator {
    while [ : ]
    do
      time=$(date +%H%M)
      if (( $time > 2300 )); then
        psanimate .3
      elif (( $time < 500 )); then
        psanimate .1
      fi
      sleep 1800
    done
  }
  if [[ $PS_AUTO_ANIMATE == 1 ]];then
    _psautoanimator & ; echo "$!" > /tmp/psautoanimator-$$
  fi
)

function pscleanup {
  echo "Cleaning the animation stuff"
  psanimate_stop
  unset PS_TASK_OVER

  # _psautoanimator_kill
  touch /tmp/psautoanimator-$$
  PID=`cat /tmp/psautoanimator-$$`
  if [[ ! -z "$PID" ]]
    then
    (kill $PID > /dev/null 2>&1)
  fi
  rm /tmp/psautoanimator-$$
}

trap pscleanup EXIT
