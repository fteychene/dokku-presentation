FROM node:6
WORKDIR /app

EXPOSE 5000

RUN echo '{ "allow_root": true }' > /root/.bowerrc

RUN npm install -g bower

ADD package.json /app/package.json
RUN npm install

ADD public /app/public
RUN cd public && bower install

ADD app.js /app/app.js
ADD config.js /app/config.js

CMD ["node", "app.js"]
