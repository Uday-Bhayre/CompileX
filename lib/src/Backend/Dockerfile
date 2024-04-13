From node:20

#create a app directory
WORKDIR /app


#install app dependencies
COPY package.*json ./

#run npm install
RUN npm install
RUN npm install ws

#Bundle app source
COPY . .


EXPOSE 8080

CMD ["npm","start"]




