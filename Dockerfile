FROM sabrehagen/desktop-environment

RUN yarn global add ngrok

RUN mkdir ~/.ngrok2
COPY ngrok.yml ~/.ngrok2

COPY entrypoint.sh /
ENTRYPOINT /entrypoint.sh