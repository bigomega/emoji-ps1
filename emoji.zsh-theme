# arr=(👾 💻 🍀 🥑 🦮 ⛰️ 🪂 🍺 🎨 🏃🏻‍♂️ 👨🏻‍🌾 🐢 🐼 🐙 🐳 🐓 🪵 🍄 🔥 🌪 🍁 🐚 🌊 🍉 🥝 🍋)
# function _emoji() {
#   day=$(date +%u)
#   time=$(date +%H%M)
#   second=$(date +%S)
#   echo $time
#   # SHOULD SLEEP
#   if (( $time > 2230 )); then
#     echo -n 🥱
#   elif (( $time > 2100 )); then
#     echo -n 
#   elif (( $time < 500 )); then
#     echo -n 🛌
#   fi
#   # if (( $hour > 30 )) ; then 
#   #     echo $RANDOM
#   #     echo -n $(date +%S)
#   # else
#   #     echo $RANDOM
#   #     echo -n "zzz"
#   # fi
#   # echo ${arr[RANDOM%${#arr[@]} + 1]}
#   # echo -n ${arr[RANDOM%${#arr[@]} + 1]}
#   return 0
# }
# for loop in $(seq 1 1000); do echo ${arr[RANDOM%${#arr[@]} + 1]};done | sort | uniq -c

# PROMPT="%(?:%{$fg_bold[green]%}${arr[RANDOM%${#arr[@]} + 1]} :%{$fg_bold[red]%}➜ )"
# PROMPT="%(?:%{$fg_bold[green]%}\$(_emoji)[\$(date +%S)] :%{$fg_bold[red]%}➜ )"
# sh /Users/bigomega/.nvm/versions/node/v16.6.0/bin/node ./emoji.js
# emoji=$(/Users/bigomega/.nvm/versions/node/v16.6.0/bin/node ./emoji.js)
# PROMT+="\$(nvm use 16.6 > /dev/null 2>&1)"
# Emoji
EMOJI="%{$fg_bold[white]%}\$(node $HOME/.oh-my-zsh/custom/themes/emoji.js)"
PROMPT="%(?:%{$fg_bold[green]%}➜"$EMOJI":%{$fg_bold[red]%}➜"$EMOJI")"
PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

function actover {
  export ACT_OVER="$(date +%H%M)"
  trap 'unset ACT_OVER' SIGUSR1
  p=$$
  ( sleep 3600; kill -SIGUSR1 $p ) &
  # echo "export ACT_OVER=""" | at now + 1 hour
  touch /tmp/psanimatepid-$$
  [ ! -z `cat /tmp/psanimatepid-$$` ] && psanimate `cat /tmp/psanimatesleep`
  # psanimate_stop
}

psanimate_stop() {
  touch /tmp/psanimatepid-$$
  PID=`cat /tmp/psanimatepid-$$`
  if [[ ! -z "$PID" ]]
    then 
    kill $PID > /dev/null 2>&1
    rm /tmp/psanimatepid-$$
  fi
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
  # (_ps_emoji_animation &)
}
