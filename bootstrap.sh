#!/usr/bin/env bash
#
# bootstrap installs things.

DOTFILES_ROOT="`pwd`"

set -e

echo ''

info () {
  printf "  [ \033[00;34m..\033[0m ] $1"
}

user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

link_files () {
  ln -s $1 $2
  success "linked $1 to $2"
}

install_dotfiles () {
  info 'installing dotfiles'

  overwrite_all=false
  backup_all=false
  skip_all=false

  for source in `find $DOTFILES_ROOT -maxdepth 2 -name \*.symlink`
  do
    dest="$HOME/.`basename \"${source%.*}\"`"

    if [ -f $dest ] || [ -d $dest ]
    then

      overwrite=false
      backup=false
      skip=false

      if "$overwrite_all" == "false" && "$backup_all" == "false" && "$skip_all" == "false"
      then
        user "File already exists: `basename $source`, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac
      fi

      if "$overwrite" == "true" || "$overwrite_all" == "true"
      then
        rm -rf $dest
        success "removed $dest"
      fi

      if "$backup" == "true" || "$backup_all" == "true"
      then
        mv $dest $dest\.backup
        success "moved $dest to $dest.backup"
      fi

      if "$skip" == "false" && "$skip_all" == "false"
      then
        link_files $source $dest
      else
        success "skipped $source"
      fi

    else
      link_files $source $dest
    fi

  done
}

run_installers () {
    target=$1
    if [ -z "$target" ]; then
      echo "target required"
      exit 1
    fi
    
    excludes=""
    case "$target" in
      "host")
        ;;
      "remote")
        excludes='flatpak|toolbox|systemd|gtk|fonts|alacritty'
        ;;
      *)
        echo "unsupported target: $target"
        exit 1
        ;;
    esac

    # find installers and run them interactively
    find . -name install.sh | egrep -v "${excludes}" | while read installer ; do echo "INSTALL ${installer}"; sh -c "${installer}" > /dev/null ; done
}

target=$1
if [ -z "$target" ]; then
  echo "target required"
  exit 1
fi

install_dotfiles
run_installers "$target"
