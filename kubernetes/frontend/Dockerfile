# Utilizar node bajo linux alpine
FROM node:alpine

# Todas las operaciones bajo la carpeta /app
WORKDIR /app

# Instalar comando serve
RUN npm install -g serve

# Copiar los archivos al contenedor
COPY srcs .

# npm install
RUN npm install

# Cuando se ejecute el contenedor haga npm run build y npm start
# Muy importante poner ambos en CMD para que coja las variables de entorno
CMD npm run build && serve -s build