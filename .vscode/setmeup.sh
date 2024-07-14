#!/bin/bash

## Quick Refs
##? To soft-reset (revert back) last git commit:
##^ git reset --soft HEAD~1
##? For soft-resetting last 3 git commits:
##^ git reset --soft HEAD~3

## Generic Aliases
alias ls='ls --color'
alias cfind='find . -exec ls -Flash --color {} \;'
alias tolower='tr [:upper:] [:lower:]'
alias toupper='tr [:lower:] [:upper:]'


## Git Commands as Aliases
alias getrepo='git rev-parse --show-toplevel 2>/dev/null'
alias getrepo-dirname='basename $(getrepo)'
alias getrepo-dirpath='echo $(getrepo)'
alias getrepo-parentdir='dirname $(getrepo)'
alias getrepo-remote='git remote get-url origin'
# getrepo-remote | cut -d ":" -f2 | cut -d "." -f1
alias getrepo-name='getrepo-remote | cut -d ":" -f2 | cut -d "." -f1'
alias getrepo-owner='getrepo-name | cut -d "/" -f1'
alias getrepo-root='getrepo-name | cut -d "/" -f2'

## Setconda Commands
alias topdir='getrepo || pwd'
alias setconda='. $(topdir)/.vscode/setconda.sh'
alias baseconda='conda activate base'
# run ymake <command> from repository root folder
alias ymake='make -C $(topdir)/.vscode' # this dynamically runs the command wrt .vscode folder
# run xmake <command> from repository root folder
alias xmake='make -f $(topdir)/.vscode/Makefile'
alias setmeup='. $(topdir)/.vscode/setmeup.sh'
alias setcolors='. $(topdir)/.vscode/colors.sh'
alias loadvars='. $(topdir)/.vscode/loadvars.sh'
alias gotoroot='cd $(getrepo)'

## Commands for Conda Enviornment
alias conda-envname="conda env list | grep \* | cut -d '*' -f1 | tr -d ' '"
alias conda-envpath="conda env list | grep \* | cut -d '*' -f2 | tr -d ' '"

## Customized Nano Editor
## Example:
## > nano ~/.bashrc --syntax=sh -
## Latest nanorc files: https://github.com/scopatz/nanorc
## Creating nanorc file:
##   - source:
##     - https://askubuntu.com/a/538674/853549
##     - https://askubuntu.com/a/90026/853549
##   - Location(s) of user's nanorc file:
##     - ~/.config/nano/nanorc
##     - ~/.nanorc
##     - /etc/nanorc
## > find /usr/share/nano -iname "*.nanorc" -exec echo include {} \; >> ~/.nanorc
# alias nano='nano -ilmq -J 100 -T 4'
alias nano='nano -im -T 4'

###################### Text Formatting ######################
## Take Column
## - usage:
##   >>> ls -FlAsh | column -t | tr -s " " | cut -d " " -f4
##   >>> ls -FlAsh | column -t | takecolumn 4
alias takecolumn='tr -s " " | cut -d " " -f'

## Split one-or-more space(s) separated text into multiple lines
## - usage:
##   >>> echo "alpha    beta  gamma delta" | splitlines
##   >>> groups | splitlines
alias splitlines='tr -s " " "\n"'

## Drop Comments
## - source: https://unix.stackexchange.com/questions/337911
## - usage:
##   >>> cat file.txt | dropcomments
## Handles both of the following scenarios.
##       - # some comment
##       -   # another comment with white spaces before the "#"
alias dropcomments='grep -v -E "^\s*#"'

## Replace only tabs on the left of each line with 4 spaces each
alias tabtospaces='expand -t 4 -i'

## Replace white spaces at the end of each line
alias trimright="sed 's/[[:blank:]]*$//'"

## Replace white spaces at the beginning of each line
alias trimleft="sed 's/^[[:blank:]]*//'"

## Replace white spaces from either ends of each line
alias trim='trimleft | trimright'

## Drop empty lines
alias dropempty="sed 's/^[[:blank:]]*$//'"

## Remove empty lines at the end of file or piped input
alias striplastemptylines="sed -e :a -e '/^\n*$/{\$d;N;ba' -e '}'"

## Replace spaces with underscores
alias space2uc="sed 's/ /_/gm'"

## Select first (n) result
alias select.first='sort | head -n 1'

## Select last (n) result
alias select.last='sort -r | head -n 1'

## Add a prefix or a Suffix
## cat <lines> | sed -E 's/.*/prefix&'
## cat <lines> | sed -E 's/.*/&suffix'
## cat <lines> | sed -E 's/.*/prefix&suffix'
## piping through functions:
## - source:
##   - https://stackoverflow.com/a/36432966/8474894
##   - https://unix.stackexchange.com/a/114129/390882
# Leaving the following function commented out as it does not work properly
# But it is good learning exercise.
# setprefix.alt() { (
#     # Usage:
#     # echo -e "alpha\nbeta\ngamma" | setprefix me 1a
#     # echo -e "alpha\nbeta\ngamma" | setprefix me 1b
#     # echo -e "alpha\nbeta\ngamma" | setprefix me 2
#     _prefix=${1:-"prefix"}; shift;
#     _option=${1:-"1"}; shift;
#     alias _applyprefix='sed -E "s/.*/${_prefix}&/"';
#     if [[ "${_option:0:1}" == "1" ]]; then
#         declare datalines=${*:-$(</dev/stdin)};
#         case "$_options" in
#             1a)
#                 for data in $(echo ${datalines}); do echo "${data}" | eval "_applyprefix"; done;
#                 ;;
#             1b)
#                 for data in ${datalines}; do echo "${data}" | eval "_applyprefix"; done;
#                 ;;
#             *)
#                 for data in ${datalines}; do echo "${data}" | eval "_applyprefix"; done;
#                 ;;
#         esac;
#     else
#         while read -r data; do echo "${data}" | eval "_applyprefix"; done;
#     fi;
#     unalias _applyprefix;
# ); }

setprefix() { (
    # Usage:
    # echo -e "alpha\nbeta\ngamma" | setprefix me
    _prefix=${1:-"prefix"};
    alias _applyprefix='sed -E "s/.*/${_prefix}&/"';
    while read -r data; do echo "${data}" | eval "_applyprefix"; done;
    unalias _applyprefix;
); }

setsuffix() { (
    # Usage:
    # echo -e "alpha\nbeta\ngamma" | setsuffix me
    _suffix=${1:-"suffix"};
    alias _applysuffix='sed -E "s/.*/&${_suffix}/"';
    while read -r data; do echo "${data}" | eval "_applysuffix"; done;
    unalias _applysuffix;
); }

## Catch SAS Log Erors
alias saslogerror='grep -inH -E "ERROR\:|_ERROR_\=1"'
alias sle='saslogerror'
alias sle.missdeps='grep -in -E "ERROR: File .*\..*\.DATA does not exist\." | grep -inv -E "ERROR: File WORK\..*\.DATA does not exist\."'
alias sasmissdeps='sle.missdeps'
alias sle.m='sle.missdeps'
alias sle.missdeps.unique='sle.missdeps | column -t -s ":" | takecolumn 8 | sort -u'
alias sle.m.u='sle.missdeps.unique'

## Decolor ANSI Colored Output
## - source:
##   - https://stackoverflow.com/a/30938702/8474894
##   - https://stackoverflow.com/a/76512982/8474894
## - example: (see preview in VS Code editor)
##   >>> cat <filepath> | decolor | code -
alias decolor.styles='sed -E "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})*)?[m,K,H,f,J]//gm"'
alias decolor.reset='sed -E "s/\x1B\([A-Z]{1}(\x1B\[[m,K,H,f,J]//gm"'
alias decolor='decolor.styles | decolor.reset'

## Get unix error Codes with Definition
## - source:
##   - https://www.perlmonks.org/?node_id=274896
##   - https://www.gnu.org/software/bash/manual/html_node/Exit-Status.html
##   - https://unix.stackexchange.com/a/125181/390882
## - TIP:
##   - Use $? for last exit code
##   - Use ${PIPESTATUS[@]} for a list of exit-status-values from the pipeline (in Bash)
##   - source: https://unix.stackexchange.com/a/254747/390882
## NOTE: The following extracts the error code defined in errorno.h file.
##       This is the closest to standardizing the error codes in Unix.
##       As such, Unix does not define all the error codes.
##       See the errno-constants here:
##       - https://learn.microsoft.com/en-us/cpp/c-runtime-library/errno-constants?view=msvc-170
## - source: https://tldp.org/LDP/abs/html/exitcodes.html
##############################################################
getunixerrorcodes() { ( perl -le 'print $!+0, "\t", $!++ for 0..127'; ) }
alias getuec='getunixerrorcodes'

## Show limits of allocated resources for a user on Linux
alias userhas='ulimit -a'

## Generate Hash with OpenSSL: Checksum
showopensslver() { ( echo -e "Using $(openssl version)\n\n"; ) }
genhash-sha256() { ( openssl sha256 ${1} | cut -d "=" -f2 | xargs ) }
genhash-md5() { ( openssl md5 ${1} | cut -d "=" -f2 | xargs ) }

## Detect duplicates in files
## - Usage:
##   - Show names and counts of the duplicates
##     >>> cat <filename> | getdupeswithcounts
##   - Show ONLY names (no counts) of the duplicates
##     >>> cat <filename> | getdupeswithcounts | dropdupescounts
##     >>> cat <filename> | getdupeslist
## - Test:
##   - Run the following:
## _T=$(cat <<< EOF
## alpha
## alpha
## beta
##    beta
## gamma
## gamma1
## aeta
## omega
## zeta
## EOF
## );
##   - Now run the following.
## echo "$_T" | sort | uniq -c
## echo "$_T" | sort | uniq -cd
## echo "$_T" | sort | uniq -cd | trimleft | takecolumn 2
alias getdupeswithcounts='sort | uniq -cd'
alias dropdupescounts='trimleft | takecolumn 2'
alias getdupeslist='getdupeswithcounts | dropdupescounts'

###############################################

## Changing DB user password
alias changedbpw='echo -e "\n${cFGBYellow}>>> Change DB Password using SQL:\n>>> ${cFGCyan}alter user ${USER} identified by ${cBGGreen}\"new-password\"${cReset} ${cFGCyan}replace${cReset} ${cBGYellow}\"old-password\"${cReset}${cFGCyan};${cReset}\n"'

############ Other Custom Commands ############

## Fill in a .gitkeep file in each empty folder
## - source:
##   - https://bytefreaks.net/gnulinux/bash/how-to-add-automatically-all-empty-folders-in-git-repository
##   - https://stackoverflow.com/questions/2810838/finding-empty-directories
## - Verify command:
##   >>> find . -type d -empty -exec echo touch '{}'/.gitkeep \;
## - Run command:
##   >>> find . -type d -empty -exec touch '{}'/.gitkeep \;
addgitkeep() { (
    _PATH=${1:-$(realpath "$(pwd)")};
    _DEBUGFLAG=${2:+"-y"};
    if [[ "${_DEBUGFLAG}" == "-y" ]]; then _DEBUGSTR=""; fi;
    find "$(realpath "${_PATH}")" -type d -empty -exec "${_DEBUGSTR}" touch '{}'/.gitkeep \;
    unset _PATH _DEBUGFLAG _DEBUGSTR;
); }

## Git Commands
## - source: https://stackoverflow.com/questions/31420290
## >>> git show -s --clor --format='' <tag>
## Extracting the tags: echo ${refname#refs/tags/}
gitshowtags() { (
    git for-each-ref refs/tags/$tagname --format='%(objecttype): %(refname) | commit: %(objectname) | description: %(contents)';
); }
gitshowtagsinfo() { ( git show -s --color --format='' "${_TAGNAME:-"${1}"}"; ); }


## Get all symlinks under a directory path
## - source: https://stackoverflow.com/questions/8513133
## - What worked:
##   >>> find . -type -l
##   >>> find . -type -ls
##   >>> find -L . -xtype l
getsymlinks() { (
    choice=${2:-"--targets"}; # options: -t|--target|--targets, -s|--source|--sources
    path=${1:-"$(pwd)"};
    case "${choice}" in
        -t|--target|--targets)
            resultcolumn=11;
            ;;
        -s|--source|--sources)
            resultcolumn=13;
            ;;
        *)
            resultcolumn=11;
            ;;
    esac;
    # show result
    find "${path}" -type l -ls | takecolumn "${resultcolumn}";
); }
alias getsl='getsymlinks'

## Create repeatitions of strings
stringrep() { (
    ## Repeats a string N number of times.
    ## Usage:
    ## >>> stringrep "#" 10
    ## output: ##########
    ##------------------------------------
    _char=${1:-"#"};
    _numrep=${2:-"20"};
    python3 -c "print('${_char}'*${_numrep})";
    unset _char _numrep;
); }

## Get mtime (time of modification) for a file
getfilemtime() { (
    ## Returns the mtime of a file.
    ## Format: yyyy-mm-dd_HH:MM:SS
    ## source: https://stackoverflow.com/a/65696621/8474894
    date +'%F_%T' -r "${_FILEPATH:-"${1}"}"
); }


###############################################

## Commands for python and pip
#
# define command: python
# - this will map to the current pip environment's python
# - code logic: https://stackoverflow.com/a/27369375/8474894
alias python='${$(which pip)/pip/python}'
# define command for upgrading pip
alias pipup="python -m pip install --upgrade pip"

# Commands for venv
VENV_DIR=".venv"
alias venv.make="setconda && python -m venv ${VENV_DIR} --prompt venv --copies"
alias venv.up="source $(topdir)/${VENV_DIR}/bin/activate && setmeup"
alias venv.down="deactivate && setmeup"
alias venv.set="setconda && venv.make && venv.up"
alias venv.clear="venv.down && rm -rf $(topdir)/.venv"
alias venv.reset="venv.clear && venv.set"

## Docs Generating Commands
alias genpdocs="pdoc -d google -h localhost -n -p 5555 --math --show-source"

## Calendar
alias pycal='python -m calendar'

###############################################

## Using NCDU
alias ncdu.run='ncdu -f $(topdir)/.vscode/config.ncdu.json'

unset \
    VENV_DIR

###############################################
