#!/bin/bash

export PYTHONHOME=/root/mambaforge
export PYTHONPATH=/root/mambaforge/lib/python3.9/site-packages:$PYTHONPATH

GPUID=0
BLENDER_BIN=/workspaces/blender-2.93.3-linux-x64/blender

RENDERER_ASSET_DIR=./data/assets
BLENDER_PROJ_PATH=./data/assets/material_lib_graspnet-v2.blend
SIM_LOG_DIR="./log/`date '+%Y%m%d-%H%M%S'`"

scene="pile"
object_set="pile_subdiv"
material_type="specular_and_transparent"
render_frame_list="2,6,10,14,18,22"
check_seen_scene=0
expname=0

NUM_TRIALS=1
METHOD='graspnerf'

mycount=0 

while (( $mycount < $NUM_TRIALS )); do
   $BLENDER_BIN $BLENDER_PROJ_PATH --background --python scripts/sim_grasp.py \
   -- $mycount $GPUID $expname $scene $object_set $check_seen_scene $material_type \
   $RENDERER_ASSET_DIR $SIM_LOG_DIR 0 $render_frame_list $METHOD \
   ---sim-gui True ---rviz
   
   python ./scripts/stat_expresult.py -- $SIM_LOG_DIR $expname
((mycount=$mycount+1));
done;

python ./scripts/stat_expresult.py -- $SIM_LOG_DIR $expname
