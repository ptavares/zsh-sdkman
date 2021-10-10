#!/usr/bin/env zsh

#####################
# COMMONS
#####################
autoload colors

#########################
# CONSTANT
#########################

BOLD="bold"
NONE="none"

#########################
# PLUGIN MAIN
#########################

[[ -z "$SDKMAN_DIR" ]] && export SDKMAN_DIR="$HOME/.sdkman"
ZSH_SDKMAN_VERSION_FILE=${SDKMAN_DIR}/version.txt

#########################
# Functions
#########################

_zsh_sdkman_log() {
  local font=$1
  local color=$2
  local msg=$3

  if [ $font = $BOLD ]
  then
    echo $fg_bold[$color] "[zsh-sdkman-plugin] $msg" $reset_color
  else
    echo $fg[$color] "[zsh-sdkman-plugin] $msg" $reset_color
  fi
}

_zsh_sdkman_check_requirement() {
    local command=$1
    _zsh_sdkman_log $NONE "blue" "#############################################"
    _zsh_sdkman_log $NONE "blue" "Looking for ${command}..."
    which "${command}" > /dev/null 2>&1
    if [[ $? -eq 1 ]]; then
        _zsh_sdkman_log $NONE "blue" "Not found"
        _zsh_sdkman_log $NONE "blue" "========================================="
        _zsh_sdkman_log $NONE "blue" "Please install ${command} on your system"
        _zsh_sdkman_log $NONE "blue" "using your favourite package manager."
        _zsh_sdkman_log $NONE "blue" "========================================="
        exit 1
    fi

}

_zsh_sdkman_check_requirement_list() {
  _zsh_sdkman_check_requirement zip
  _zsh_sdkman_check_requirement unzip
  _zsh_sdkman_check_requirement curl
}


_zsh_sdkman_last_version() {
  echo $(curl -s https://get.sdkman.io/ | grep SDKMAN_VERSION | head -n 1 | cut -d '"' -f 2)
}

_zsh_sdkman_install() {
  _zsh_sdkman_log $NONE "blue" "#############################################"
  _zsh_sdkman_log $BOLD "blue" "Installing sdkman..."
  _zsh_sdkman_check_requirement_list
  local last_version=$(_zsh_sdkman_last_version)
  _zsh_sdkman_log $NONE "blue" "-> retrieve last version of sdkman..."
  _zsh_sdkman_log $NONE "blue" "  -> download and install sdkman ${last_version}"
  curl -s "https://get.sdkman.io" | bash > /dev/null 2>&1
  echo ${last_version} > ${ZSH_SDKMAN_VERSION_FILE}
  _zsh_sdkman_log $BOLD "green" "Install OK"
  _zsh_sdkman_log $NONE "blue" "#############################################"
}


update_zsh_sdkman() {
  _zsh_sdkman_log $NONE "blue" "#############################################"
  _zsh_sdkman_log $BOLD "blue" "Checking new version of sdkman..."

  local current_version=$(cat ${ZSH_SDKMAN_VERSION_FILE})
  local last_version=$(_zsh_sdkman_last_version)

  if is-at-least ${last_version//+/.} ${current_version}
  then
    _zsh_sdkman_log $BOLD "green" "Already up to date, current version : ${current_version}"
  else
    _zsh_sdkman_log $NONE "blue" "-> Updating sdkman..."
     sdk selfupdate force > /dev/null 2>&1
     echo ${version} > ${ZSH_SDKMAN_VERSION_FILE}
    _zsh_sdkman_log $BOLD "green" "Update OK"
  fi
  _zsh_sdkman_log $NONE "blue" "#############################################"
}

_zsh_sdkman_load() {
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    # # export PATH
    # export PATH=${PATH}:${SDKMAN_DIR}
}


# install sdkman if it isnt already installed
[[ ! -f "${ZSH_SDKMAN_VERSION_FILE}" ]] &&_zsh_sdkman_install

# load sdkman if it is installed
if [[ -f "${ZSH_SDKMAN_VERSION_FILE}" ]]; then
    _zsh_sdkman_load
    # Rebuild completion
    0=${(%):-%N}
    fpath=(${0:A:h} $fpath)
    autoload -U compinit && compinit -C
fi

########################################################
##### ALIASES
########################################################
alias sdki='sdk install'
alias sdkun='sdk uninstall'
alias sdkls='sdk list'
alias sdku='sdk use'
alias sdkd='sdk default'
alias sdkc='sdk current'
alias sdkup='sdk upgrade'
alias sdkv='sdk version'
alias sdkb='sdk broadcast'
alias sdko='sdk offline'
alias sdksu='sdk selfupdate'
alias sdkf='sdk flush'

unset -f _zsh_sdkman_install _zsh_sdkman_check_requirement_list _zsh_sdkman_check_requirement _zsh_sdkman_load
