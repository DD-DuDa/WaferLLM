set -e

P=16

M=64
N=64

GROUP_NUM=2

fabric_w=$(($P + 7))
fabric_h=$(($P + 2))

Mt=$(($M / $P))
Nt=$(($N / $P))

pe_num_group=$(($P / $GROUP_NUM))
root_1st_phase=$((pe_num_group / 2))
root_2nd_phase=$(((($GROUP_NUM / 2) * pe_num_group) + root_1st_phase))

echo "P=$P, M=$M, N=$N, group_num=$GROUP_NUM, pe_num_group=$pe_num_group, root_1st_phase=$root_1st_phase, root_2nd_phase=$root_2nd_phase"

cslc --arch=wse3 ./src/layout.csl --fabric-dims="$fabric_w","$fabric_h" --fabric-offsets=4,1 \
    --params=P:"$P",Mt:"$Mt",Nt:"$Nt",pe_num_group:"$pe_num_group",root_1st_phase:"$root_1st_phase",root_2nd_phase:"$root_2nd_phase" \
    -o out --memcpy --channels 1

cs_python ./launch_sim.py --P "$P" --M "$M" --N "$N"