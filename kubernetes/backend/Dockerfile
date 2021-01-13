# Utilizar node bajo linux alpine
FROM node:alpine

# Todas las operaciones bajo la carpeta /app
WORKDIR /app

# Copiar los archivos al contenedor
COPY srcs .

# npm install
RUN npm install

# cuando se ejecute el contenedor haga npm start
CMD npm start