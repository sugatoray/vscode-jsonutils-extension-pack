#!/usr/bin/bash

### The terminal color library for bash

# source: https://stackoverflow.com/a/28938235/8474894
# example:
# echo "${BRed}Hello${Color_Reset} ${BIRed}World${Color_Reset}!..."

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White


###########################################################
##  Define terminal colors with tput
###########################################################
##
## source: https://stackoverflow.com/a/20983251/8474894
##
## Foreground & Background color commands
## 
## tput setab [1-7] # Set the background color using ANSI escape
## tput setaf [1-7] # Set the foreground color using ANSI escape
## 
###-----------------------------------------------------###
## Num  Colour    #define         R G B
##
## 0    black     COLOR_BLACK     0,0,0
## 1    red       COLOR_RED       1,0,0
## 2    green     COLOR_GREEN     0,1,0
## 3    yellow    COLOR_YELLOW    1,1,0
## 4    blue      COLOR_BLUE      0,0,1
## 5    magenta   COLOR_MAGENTA   1,0,1
## 6    cyan      COLOR_CYAN      0,1,1
## 7    white     COLOR_WHITE     1,1,1
##
###-----------------------------------------------------###
## Text Mode Commands
##
## tput bold    # Select bold mode
## tput dim     # Select dim (half-bright) mode
## tput smul    # Enable underline mode
## tput rmul    # Disable underline mode
## tput rev     # Turn on reverse video mode
## tput smso    # Enter standout (bold) mode
## tput rmso    # Exit standout mode
###-----------------------------------------------------###
## Cursor Movement Commands
##
## tput cup Y X # Move cursor to screen postion X,Y (top left is 0,0)
## tput cuf N   # Move N characters forward (right)
## tput cub N   # Move N characters back (left)
## tput cuu N   # Move N lines up
## tput ll      # Move to last line, first column (if no cup)
## tput sc      # Save the cursor position
## tput rc      # Restore the cursor position
## tput lines   # Output the number of lines of the terminal
## tput cols    # Output the number of columns of the terminal
###-----------------------------------------------------###
## Clear and insert commands
##
## tput ech N   # Erase N characters
## tput clear   # Clear screen and move the cursor to 0,0
## tput el 1    # Clear to beginning of line
## tput el      # Clear to end of line
## tput ed      # Clear to end of screen
## tput ich N   # Insert N characters (moves rest of line forward!)
## tput il N    # Insert N lines
###-----------------------------------------------------###
## Other commands
##
## tput sgr0    # Reset text format to the terminal's default
## tput bel     # Play a bell
##
###-----------------------------------------------------###

## Example:
democolors() {
    echo -e "\n\t${cBGBYellow}SOURCE:${cReset} ${cDim}${cFGYellow}some/source${cReset}\n\t${cBGBGreen}TARGET:${cReset} ${cDim}${cFGGreen}some/target${cReset}\n";
}

# Reset
cReset=$(tput sgr0);                     # Text Reset

cBold=$(tput bold);                      # Select bold mode
cDim=$(tput dim);                        # Select dim (half-bright) mode
cSmul=$(tput smul);                      # Enable underline mode
cRmul=$(tput rmul);                      # Disable underline mode
cRev=$(tput rev);                        # Turn on reverse video mode
cSmso=$(tput smso);                      # Enter standout (bold) mode
cRmso=$(tput rmso);                      # Exit standout mode

# Foreground Colors: Regular
cFGBlack=$(tput setaf 0);                # Black
cFGRed=$(tput setaf 1);                  # Red
cFGGreen=$(tput setaf 2);                # Green
cFGYellow=$(tput setaf 3);               # Yellow
cFGBlue=$(tput setaf 4);                 # Blue
cFGPurpule=$(tput setaf 5);              # Purpule
cFGCyan=$(tput setaf 6);                 # Cyan
cFGWhite=$(tput setaf 7);                # White

# Foreground Colors: Bold
cFGBBlack="${cBold}${cFGBlack}";         # Black
cFGBRed="${cBold}${cFGRed}";             # Red
cFGBGreen="${cBold}${cFGGreen}";         # Green
cFGBYellow="${cBold}${cFGYellow}";       # Yellow
cFGBBlue="${cBold}${cFGBlue}";           # Blue
cFGBPurpule="${cBold}${cFGPurpule}";     # Purpule
cFGBCyan="${cBold}${cFGCyan}";           # Cyan
cFGBWhite="${cBold}${cFGWhite}";         # White

# Foreground Colors: Underline
cFGBBlack="${cSmul}${cFGBlack}";         # Black
cFGBRed="${cSmul}${cFGRed}";             # Red
cFGBGreen="${cSmul}${cFGGreen}";         # Green
cFGBYellow="${cSmul}${cFGYellow}";       # Yellow
cFGBBlue="${cSmul}${cFGBlue}";           # Blue
cFGBPurpule="${cSmul}${cFGPurpule}";     # Purpule
cFGBCyan="${cSmul}${cFGCyan}";           # Cyan
cFGBWhite="${cSmul}${cFGWhite}";         # White

# Background Colors: Regular
cBGBlack=$(tput setab 0);                # Black
cBGRed=$(tput setab 1);                  # Red
cBGGreen=$(tput setab 2);                # Green
cBGYellow=$(tput setab 3);               # Yellow
cBGBlue=$(tput setab 4);                 # Blue
cBGPurpule=$(tput setab 5);              # Purpule
cBGCyan=$(tput setab 6);                 # Cyan
cBGWhite=$(tput setab 7);                # White

# Background Colors: Bold
cBGBBlack="${cBold}${cBGBlack}";         # Black
cBGBRed="${cBold}${cBGRed}";             # Red
cBGBGreen="${cBold}${cBGGreen}";         # Green
cBGBYellow="${cBold}${cBGYellow}";       # Yellow
cBGBBlue="${cBold}${cBGBlue}";           # Blue
cBGBPurpule="${cBold}${cBGPurpule}";     # Purpule
cBGBCyan="${cBold}${cBGCyan}";           # Cyan
cBGBWhite="${cBold}${cBGWhite}";         # White

# Background Colors: Underline
cBGUBlack="${cSmul}${cBGBlack}";         # Black
cBGURed="${cSmul}${cBGRed}";             # Red
cBGUGreen="${cSmul}${cBGGreen}";         # Green
cBGUYellow="${cSmul}${cBGYellow}";       # Yellow
cBGUBlue="${cSmul}${cBGBlue}";           # Blue
cBGUPurpule="${cSmul}${cBGPurpule}";     # Purpule
cBGUCyan="${cSmul}${cBGCyan}";           # Cyan
cBGUWhite="${cSmul}${cBGWhite}";         # White
