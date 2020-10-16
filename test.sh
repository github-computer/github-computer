# 1. run container from environment variables
# 2. test container http endpoint
# 3. exit?

export GITHUB_REPOSITORY=github-computer/github-computer
export GITHUB_SHA=github-sha

# Set the desktop environment test container name
TEST_CONTAINER_NAME=desktop-environment-test-$(date +%s)

# Start the desktop environment test container
docker run \
  --detach \
  --name $TEST_CONTAINER_NAME \
  --rm \
  docker.pkg.github.com/$GITHUB_REPOSITORY/desktop-environment:$GITHUB_SHA \
  sleep infinity

# Wait until the desktop environment test container is running before proceeding
until docker inspect $TEST_CONTAINER_NAME | grep Status | grep -m 1 running >/dev/null; do sleep 1; done

# Start the vnc server inside the desktop environment test container
docker exec -it $TEST_CONTAINER_NAME vncserver :1 -autokill -SecurityTypes none -xstartup /usr/bin/i3

# Start the vnc client inside the desktop environment test container
docker exec -it $TEST_CONTAINER_NAME zsh -c "nohup /opt/noVNC/utils/launch.sh --listen 8080 &"

# Wait until the vnc client is ready to accept connections
until docker exec -it $TEST_CONTAINER_NAME netstat -tulpn | grep -q 8080; do sleep 1; done

echo =============================================
# Check desktop environment vnc server started successfully
docker exec -it $TEST_CONTAINER_NAME zsh -c "curl localhost:8080"
docker exec -it $TEST_CONTAINER_NAME zsh -c "curl --silent localhost:8080 | grep -iq vnc"
TEST_RESULT=$?

# Remove desktop environment test container
docker rm -f $TEST_CONTAINER_NAME

# Exit with test result exit code
exit $TEST_RESULT
