FROM nginx:stable-alpine

LABEL image-name="development"

COPY ./nginx.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
