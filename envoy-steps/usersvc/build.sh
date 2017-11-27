DIR=$(dirname $0)

docker build -t usersvc:step1 ${DIR}

if [ -n "" ]; then
    docker tag usersvc:step1 usersvc:step1
    docker push usersvc:step1
fi
