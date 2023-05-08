FROM nginx:stable-alpine

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ssl_certificate.crt /etc/ssl/certs/ssl_certificate.crt
COPY ssl_certificate.key /etc/ssl/private/ssl_certificate.key

CMD ["nginx", "-g", "daemon off;"]
