DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ -z "$1" ]
then
      echo "\$1 is empty"
      echo "Please use 'add' 'remove'"
      echo "Closing"
else  
      if [ -z "$2" ]
      then
            echo "\$2 is empty"
            echo "Please add the port number you wish to add or remove"
            echo "Closing"
      else
            ACTION="$(tr [A-Z] [a-z] <<< "$1")"
            case $ACTION in
                  "add")
                  echo "adding new docker"
                  docker build -t node-web "$DIR/"
                  docker run -d -p $2:8080 -e EXPOSED_PORT=$2 node-web
                  /usr/local/bin/consul services register -name=web -id=web${2} -port=${2}
                  ;;
                  "remove")
                  echo "removing docker"
                  docker kill $(docker ps | grep $2 | awk '{print $1}')
                  /usr/local/bin/consul services deregister -id=web${2}
                  ;;
                  *)
                  echo "Unkown action"
                  echo "Closing"
                  ;;
            esac
      fi
fi