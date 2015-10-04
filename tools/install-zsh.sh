set -e

# Use colors, but only if connected to a terminal, and that terminal
# supports them.
tput=$(which tput)
if [ -n "$tput" ]; then
    ncolors=$($tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
  RED="$(tput setaf 1)"
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  BLUE="$(tput setaf 4)"
  BOLD="$(tput bold)"
  NORMAL="$(tput sgr0)"
else
  RED=""
  GREEN=""
  YELLOW=""
  BLUE=""
  BOLD=""
  NORMAL=""
fi
CHECK_ZSH_INSTALLED=$(grep /zsh$ /etc/shells | wc -l)
if [ ! $CHECK_ZSH_INSTALLED -ge 1 ]; then
  printf "${YELLOW}Zsh is not installed!${NORMAL} Please install zsh first!\n"
  exit
fi
unset CHECK_ZSH_INSTALLED

if [ ! -n "$DEVIL" ]; then
  DEVIL=~/.devil
fi

if [ -d "$DEVIL" ]; then
  printf "${YELLOW}You already have DEVIL installed.${NORMAL}\n"
  printf "You'll need to remove $DEVIL if you want to re-install.\n"
  exit
fi

# Prevent the cloned repository from having insecure permissions. Failing to do
# so causes compinit() calls to fail with "command not found: compdef" errors
# for users with insecure umasks (e.g., "002", allowing group writability). Note
# that this will be ignored under Cygwin by default, as Windows ACLs take
# precedence over umasks except for filesystems mounted with option "noacl".
umask g-w,o-w

printf "${BLUE}Cloning DEVIL...${NORMAL}\n"
hash git >/dev/null 2>&1 || {
  echo "Error: git is not installed"
  exit 1
}
env git clone --depth=1 https://github.com/colynb/devil.git $DEVIL || {
  printf "Error: git clone of devil repo failed\n"
  exit 1
}

printf "${BLUE}Looking for and updating an existing zsh config...${NORMAL}\n"
if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
  printf "${YELLOW}Found ~/.zshrc.${NORMAL}\n";
  echo "\nexport DEVIL=$DEVIL" >> ~/.zshrc
  echo "\nsource $DEVIL/devil.sh" >> ~/.zshrc
fi

printf "${GREEN}"
echo ''
echo '    ____  _______    ________ '
echo '   / __ \/ ____/ |  / /  _/ / '
echo '  / / / / __/  | | / // // /  '
echo ' / /_/ / /___  | |/ // // /___'
echo '/_____/_____/  |___/___/_____/'
echo ''
echo 'Devil CLI is now installed!'
echo ''
echo 'Run these commands:'
echo '  devil install'
echo '  devil up'
echo ''
printf "${NORMAL}"
env zsh
