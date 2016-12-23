#!/bin/bash
# Implementation of the Poor Man's Profiler
# by Giovanni TATARANNI
# https://github.com/gtataranni

##########################
# Parameters: customize as needed.
# A good number of samples is the one that, if doubled, outputs the same flame graph 
#   (the same proportion of samples per function)
# NOTE: Be sure that nSamplesPerExec * sleepTimeMin is greater than the running time of the target application

nExec=10
nSamplesPerExec=600
sleepTimeMin=0.1
sleepTimeMax=0.5

##########################

command -v flamegraph.pl >/dev/null 2>&1 || { echo >&2 "I require flamegraph.pl but it's not installed.
Please get it at https://github.com/brendangregg/FlameGraph
and add it to your PATH.
Aborting."; exit 1; }

if [[ $# < 3 ]]; then
  echo "ERROR: missing argument."
  echo "Usage: $0 path-to-exec gdb-commands-file output-dir"
  echo "Aborting."
  exit -1
fi

myExecPath=$1
gdbCommands=$2
outputDir=$3
gdbLogFile="$outputDir"/gdb.log
flameOutName="$outputDir"/flame_out.svg
outputFile="$outputDir"/samples.folded


echo "" > $gdbLogFile

c=0

for i in $(seq 1 $nExec)
do
  gdb $myExecPath -x $gdbCommands --batch -q &
  GDB_PID=$!
  for j in $(seq 1 $nSamplesPerExec)
  do
    ps -p $GDB_PID
    if [[ $? = 0 ]] ; then # if gdb is still running 
        sleep $sleepTimeMin
        kill -2 $(pidof $myExec)
        ((c++))
        sleep $(python -c "import random;print('{0:.1f}'.format(random.uniform($sleepTimeMin, $sleepTimeMax)))")
    else
        break
    fi
  done
  wait
done

cat $gdbLogFile |./stackcollapse_gdb_log.py > $outputFile
cat $outputFile | flamegraph.pl > $flameOutName

echo "Sampling done"
echo "$c samples collected"
exit 0
