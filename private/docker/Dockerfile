FROM node:4.4.7

WORKDIR /usr/src/app
ADD bundle /usr/src/app
RUN cd ./programs/server && npm install

CMD ["node", "main.js"]
