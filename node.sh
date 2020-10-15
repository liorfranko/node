DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
docker build -t node-web "$DIR/"
docker run -p 8081:8080 -it node-web