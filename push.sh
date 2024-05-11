# auto push image

remote="docker.io/ben0i0d/jupyter"

# Python
target=(py-c py-g scipy-c scipy-g scrpy pyflink pyspark pyai-c pyai-g)

for i in {0..9}; do
    podman push $remote:${target[i]}
done

# Other
target=(julia maple mma matlab-minimal matlab-mcm sage octave r sage scilab)

for i in {0..9}; do
    podman push $remote:${target[i]}
done