#!/bin/bash

cores=4
vnfs=l3fwd
end=$((SECONDS+60))
params=("0c600" "0x300" "0x180" "0xc0" "0x60" "0x30" "0x18" "0xc" "0x6" "0x3")
> tmp.csv

cd /home/qiong/Splash-3-3.0/codes/apps/water-nsquared

for param in "${params[@]}"; do
    # clear or create a new CSV file for each iteration
    > ~/resource_contention/DDIO/way_allocated_sensitive/tmp_${param}.csv

    # set pqos llcway parameters
    sudo pqos -e "llc:2=${param}"

    # reset timer
    end=$((SECONDS+60))

    while [ $SECONDS -lt $end ]; do
        #  run main code and save ooutput
        sudo pqos -o ~/resource_contention/DDIO/way_allocated_sensitive/tmp_${vnfs}_${param}.csv &
        pqos_pid=$!

        sudo taskset -c "${cores}" ./WATER-NSQUARED < ~/Splash-3/codes/apps/water-nsquared/inputs/parsec_simlarge

        sudo kill $pqos_pid
        # sleep 1
    done
done
