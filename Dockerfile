FROM sabrehagen/desktop-environment

RUN yarn global add ngrok

COPY entrypoint.sh /

ENTRYPOINT /entrypoint.sh