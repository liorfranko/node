DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
docker build -t node-web "$DIR/"
# echo $1
if [ -z "$1" ]
then
      echo "\$1 is empty"
else
      echo "starting docker port $1"
      docker run -d -p $1:8080 -e EXPOSED_PORT=$1 node-web
fi