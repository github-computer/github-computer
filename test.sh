# 1. run container from environment variables
# 2. test container http endpoint
# 3. exit?

export GITHUB_REPOSITORY=github-computer/github-computer

# Set the desktop environment test container name
TEST_CONTAINER_NAME=desktop-environment-test-$(date +%s)

# Start the desktop environment test container
docker run \
  --interactive \
  --name $TEST_CONTAINER_NAME \
  --rm \
  --tty \
  docker.pkg.github.com/$GITHUB_REPOSITORY/desktop-environment:$DESKTOP_ENVIRONMENT_CONTAINER_TAG