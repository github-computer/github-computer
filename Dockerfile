FROM node:latest

RUN yarn global add http-server

ENTRYPOINT /entrypoint.sh