# SPDX-License-Identifier: GPL-3.0-or-later
prompt_env_setup () {
    PROMPT='%{%f%b%k%}$(prompt_env_make)'
    prompt_opts=(subst cr percent sp)
}

prompt_env_segment() {
  if [[ $(print -P "$2") = "$3" ]]; then
    return
  fi
  echo -n "%F{$1}%B$2%f%b "
}

prompt_env_env() {
    prompt_env_segment $1 "$2=$(eval echo \$$2)" "$2=$3"
}

prompt_env_make() {
  prompt_env_segment red $(jobs) ""
  prompt_env_env green PWD ~
  prompt_env_env red SUDO_USER ""
script_begin
echo "  prompt_env_env red USER $USER"
echo "  prompt_env_env red HOST $HOSTNAME"
script_end
  prompt_env_env green ZSH_VERSION
  echo '\n> '
}

prompt_env_setup "$@"

