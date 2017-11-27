DIR=$(dirname $0)

docker build -t edge-envoy:step2 ${DIR}

if [ -n "" ]; then
    docker tag edge-envoy:step2 edge-envoy:step2
    docker push edge-envoy:step2
fi
