#!/bin/bash
if [ ! -t 1 ] ; then
  cat "$@"
  exit 0
fi

ncol=`tput cols`

# If you modify the cat, be sure to mantain the same length in every line (newline excluded).
# Leave an empty array index where you want the cat output, and specify it in OUTPUT_INDEX.
# Modify UPPER and LOWER_LINE INDEX and CHAR if you want to modify the appearance and position
# of the two delimiters, or set their index at -1 if you don't want them.

t[0]='  ∧＿∧  '
t[1]=' ( ･ω･) '
t[2]='―∪――――∪―'
t[4]='________'
t[5]=' |    | '
t[6]=' |    | '
t[7]='  U  U  '

#################################
#                               #
# Modify these constants if you #
# modify the drawing            #
#                               #
#################################

# Drawing width

DRAWING_WIDTH=8

# At which index of the array t (declared above) should
# print the input file

OUTPUT_INDEX=3

# Characters to use for the text delimiter, and at which
# indices they should be printed

UPPER_LINE_CHAR="―"
LOWER_LINE_CHAR="_"
UPPER_LINE_INDEX=2
LOWER_LINE_INDEX=4

# Padding before and after the printed file. No padding
# could give unwanted results (see issue #4)

PADDING=1

# Percentage that indicates the position of the drawing
# in the terminal. 0 = align to the left, 100 = align to 
# the right

DRAWING_POSITION=25


#################################

arrayLen=${#t[@]}
halfDrawingLen=$(($DRAWING_WIDTH / 2))
leadingSpaces=$(($ncol * $DRAWING_POSITION / 100 - $halfDrawingLen))
if [[ $leadingSpaces -lt 0 ]]; then
  leadingSpaces=0
fi
trailingSpaces=$(($ncol - $leadingSpaces - $DRAWING_WIDTH))
if [[ $leadingSpaces -gt $(($ncol - $DRAWING_WIDTH)) ]]; then
    leadingSpaces=$(($ncol - $DRAWING_WIDTH))
    trailingSpaces=0
fi
echo ""
for i in $(seq 0 $arrayLen); do
  if [[ $i = $OUTPUT_INDEX ]]; then
    for n in $(seq 1 $PADDING); do
      echo ""
    done
    cat "$@"
    for n in $(seq 1 $PADDING); do
      echo ""
    done
  else
    car=""
    if [[ $i = $UPPER_LINE_INDEX ]]; then
      car=$UPPER_LINE_CHAR
    elif [[ $i = $LOWER_LINE_INDEX ]]; then
      car=$LOWER_LINE_CHAR
    else
      car=" "
    fi
    for s in $(seq 1 $leadingSpaces); do
      printf "$car"
    done
    printf "${t[$i]}"
    if [[ $i -eq $LOWER_LINE_INDEX || $i -eq $UPPER_LINE_INDEX ]]; then
      for s in $(seq 1 $trailingSpaces); do
        printf "$car"
      done
      printf "\n"
    else
      printf "\n"
    fi
  fi
done
echo ""
