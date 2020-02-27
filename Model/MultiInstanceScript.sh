#!/bin/dash

path="/home/public/intanceTree/"
model="/home/public/VRP/"

ins="e30"

cd $path$ins

for i in {1..10}
do
  cp $ins"_"$i"/alldata.txt" $model
  cd $model
  mkdir backups

  python3 Runner.py
  mv _* tiempo.txt estado_final_clients.txt backups $path$ins"/"$ins"_"$i
  rm alldata.txt

  cd $path$ins

done