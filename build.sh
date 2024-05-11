# auto build image

remote="docker.io/ben0i0d/jupyter"

arch="amd64"

# Python
source=(python/cpu python/gpu scipy/cpu scipy/gpu scrpy pyflink pyspark pyai/cpu pyai/gpu)
target=(py-c py-g scipy-c scipy-g scrpy pyflink pyspark pyai-c pyai-g)

for arch in $arch; do
    for i in {0..9}; do
        podman build --arch=$arch -t $remote:${target[i]} ${source[i]}
    done
done

# Other
source=(julia maple mathematica matlab/minimal matlab/mcm sagemath octave r sagemath scilab)
target=(julia maple mma matlab-minimal matlab-mcm sage octave r sage scilab)

for arch in $arch; do
    for i in {0..9}; do
        podman build --arch=$arch -t $remote:${target[i]} ${source[i]}
    done
done


