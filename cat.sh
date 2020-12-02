#!/bin/bash

ncol=`tput cols`
t[0]='　∧＿∧  \n'
t[1]=' ( ･ω･) \n'
t[2]='―∪――――∪―'
t[4]='________'
t[5]=' |　　| \n'
t[6]=' |　　| \n'
t[7]='  U￣U  \n'

nspaces=$(($ncol / 2 - 4))
trailspaces=$(($ncol / 2 - 4))
echo ""
for i in {0..7}
do
  if [ $i -eq 3 ]; then
    cat $@
  else
    car=""
    if [ $i -eq 2 ]; then
      car="―"
    elif [ $i -eq 4 ]; then
      car="_"
    else
      car=" "
    fi
    for s in `seq 1 $nspaces`; do
      printf "$car"
    done
    printf "${t[$i]}"
    if [ $i -eq 2 -o $i -eq 4 ]; then
      if [ $i -eq 2 ]; then
        car="―"
      else
        car="_"
      fi
      for s in `seq 1 $trailspaces`; do
        printf "$car"
      done
      printf "\n"
    fi
  fi
done
echo ""
