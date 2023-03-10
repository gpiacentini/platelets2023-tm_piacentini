#!/bin/bash

RUNS=100
RAB_DIST_MORE=(0 0.01 0.015 0.05 0.2)
RAB_ANGLE=(0 0.0349066 0.0872665 0.261799 0.349066)
QUEUE=parallel-cpu


for i in ${!RAB_DIST_MORE[@]}; do
    rab_dist_more=${RAB_DIST_MORE[$i]}
    rab_angle=${RAB_ANGLE[$i]}
    for j in $(seq 1 $RUNS); do
        CLEARML_QUEUE=$QUEUE python main.py \
        -cn single-hole \
        params.errors.rab_dist_more=$rab_dist_more \
        params.errors.rab_angle=$rab_angle \
        init.platelets.nests=1 \
        init.platelets.nest.platelets=50 \
        scenario.ntb=[7] \
        clearml.tags=single-rab
    done
done
