#!/bin/bash
for i in 1 2 3 4; do while : ; do : ; done & done  #cpu stress test
#(multicore - killed on exit)
echo "Quadcore cpu stress test"
echo "Test is running..."
echo "Press 1 to stop test"
while read -s -r -n 1 key
   do
      if [ $key == '1' ]; then
	 echo "Bye..."
 	 killall -15 stress.sh #Ends process safetily
      fi
   sleep 1
done
