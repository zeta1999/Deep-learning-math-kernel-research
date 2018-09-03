#/bin/bash

# googlenet_v3
# batch-size: 1
# SKX 8180 2S


source ./scripts/best_configs/common.sh $@

# googlenet_v3:conv_1_1_conv2d, ['ic', '32', 'ih', '149', 'oc', '32', 'oh', '147', 'kh', '3']
NSOCKETS=2 ./scripts/run.sh -c -i32 -h149 -o32 -H147 -n1 --blk-i=2 --blk-o=2 --flt-t=17 --tile-size=7 --execution-mode=0xa040 --output-as-blocked=true -p0 -P0 $COMMON  
sleep 1
# googlenet_v3:conv_2_2_conv2d, ['ic', '32', 'ih', '147', 'oc', '64', 'oh', '147', 'kh', '3', 'ph', '1']
NSOCKETS=2 ./scripts/run.sh -c -i32 -h147 -o64 -H147 -n1 --blk-i=2 --blk-o=4 --flt-t=17 --tile-size=7 --execution-mode=0xa040 $COMMON 
sleep 1
# googlenet_v3:conv_4_4_conv2d, ['ic', '80', 'ih', '73', 'oc', '192', 'oh', '71', 'kh', '3']
NSOCKETS=2 ./scripts/run.sh -c -i80 -h73 -o192 -H71 -n1 --blk-i=5 --blk-o=1 --pat-o=12 --flt-t=9 --tile-size=7 --execution-mode=0xa061 --output-as-blocked=true -p0 -P0 $COMMON 
sleep 1
# googlenet_v3:mixed_tower_1_conv_1_conv2d, ['ic', '64', 'ih', '35', 'oc', '96', 'oh', '35', 'kh', '3', 'ph', '1']
NSOCKETS=2 ./scripts/run.sh -c -i64 -h35 -o96 -H35 -n1 --blk-i=4 --blk-o=3 --flt-t=6 --tile-size=7 --execution-mode=0xa000 --output-as-blocked=true $COMMON 
sleep 1
# googlenet_v3:mixed_tower_1_conv_2_conv2d, ['ic', '96', 'ih', '35', 'oc', '96', 'oh', '35', 'kh', '3', 'ph', '1']
NSOCKETS=2 ./scripts/run.sh -c -i96 -h35 -o96 -H35 -n1 --blk-i=6 --blk-o=1 --flt-t=6 --tile-size=7 --execution-mode=0xa000 --output-as-blocked=true $COMMON 
sleep 1
# googlenet_v3:mixed_9_tower_1_conv_1_conv2d, ['ic', '448', 'ih', '8', 'oc', '384', 'oh', '8', 'kh', '3', 'ph', '1']
NSOCKETS=2 ./scripts/run.sh -c -i448 -h8 -o384 -H8 -n1 --blk-i=7 --blk-o=6 --flt-t=4 --tile-size=7 --execution-mode=0xa000 --streaming-input=0 $COMMON 
sleep 1
