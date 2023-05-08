FROM node:14.18.0

RUN npm install -g http-server

RUN npm install --global gulp-cli

RUN npm install --global @vue/cli

WORKDIR /var/www

COPY . .

RUN chown -R www-data:www-data /var/www

EXPOSE 3000
