FROM node:latest
RUN mkdir /socket

WORKDIR /socket

CMD ['ln', '-s', '${SOCKET_FILES_PATH}', './app']

COPY ./app /socket

EXPOSE 5000

CMD ["/bin/bash", "-c", "npm install && npm start"]