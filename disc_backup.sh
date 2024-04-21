#### Shell script to assist in backing up your games. Local legislation and copyright laws apply, use with caution!

### Setup section. Change the locations according to your setup
PS1_Games="~/"
PS2_Games="~/"
PC_Games="~/"


echo Welcome to my game back up assistant!
echo ------------------------------------
echo
echo "What system is the game for?"
echo "1. PS1"
echo "2. PS2"
echo "3. PC"
echo
read SYSTEM
SYSTEM=$(echo $SYSTEM | tr '[:upper:]' '[:lower:]')
clear
echo "What drive is the disc in? (sr0, sr1, etc) if unsure, try leaving empty."
read DRIVE
# Change DRIVE to sr0, if option was left blank
if [ -z "$DRIVE" ]; then
    DRIVE=sr0
fi
echo "What is the name of the game?"
read GAME
clear
if [ "$SYSTEM" == "1" ]; then
    if command -v cdrdao &> /dev/null; then
        clear
        echo "Attempting to copy image from $DRIVE to $PS1_Games$GAME"
        cdrdao read-cd --read-raw --datafile "$PS1_GAMES$GAME.bin" --device /dev/$DRIVE --driver generic-mmc-raw "$PS1_GAMES$GAME.cue"
    else
        clear
        echo "This script utilizes cdrdao (https://cdrdao.sourceforge.net/) for PS1 titles. Please install it and try again."
    fi
elif [ "$SYSTEM" == "2" ]; then
    clear
    echo "Attempting to copy image from $DRIVE to $PS2_Games$GAME"
    dd if=/dev/$DRIVE of=$PS2_GAMES$GAME.iso
elif [ "$SYSTEM" == "3" ]; then
    clear
    echo "Attempting to copy image from $DRIVE to $PC_Games$GAME"
    dd if=/dev/$DRIVE of=$PC_GAMES$GAME.iso
else
    clear
    echo "Incorrect system selection. Please use the numbers specified in the menu."
fi

