FROM node:23

RUN npm install -g http-server

RUN npm install --global gulp-cli

RUN npm install --global @vue/cli

WORKDIR /var/www

COPY . .

RUN chown -R www-data:www-data /var/www

EXPOSE 3000
