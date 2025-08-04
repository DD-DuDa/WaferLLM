set -e

P=5

M=20
N=20
K=20

Mt=$(($M / $P))
Kt=$(($K / $P))
Nt=$(($N / $P))

fabric_w=$(($P + 7))
fabric_h=$(($P + 2))

cslc --arch=wse3 ./src/layout.csl --fabric-dims="$fabric_w","$fabric_h" --fabric-offsets=4,1 \
    --params=P:"$P",Mt:"$Mt",Kt:"$Kt",Nt:"$Nt" \
    -o out --memcpy --channels 1

cs_python ./launch_sim.py --P "$P" --M "$M" --K "$K" --N "$N"


rm -rf simfab_traces
rm *.json
rm sim.log