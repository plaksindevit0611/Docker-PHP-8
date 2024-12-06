# Docker-PHP-8

Docker is intended for projects on Laravel version 10.*.

# Included in this docker
1. PHP 8.3
2. MySQL 8
3. Nginx
4. Node v23
5. Mailhog
6. phpmyadmin
7. MongoDB
8. Redis
9. Rabbitmq

# Commands

1. Show this help
```bash
make help
```
2. Build all containers
```bash
make build
```
3. Start all containers (in background)
```bash
make up
```
4. Stop all started containers
```bash
make down
```
5. Enter to PHP container
```bash
make sh-php
```
6. Enter to PHP Root container
```bash
make sh-php-root
```
7. Enter to Mongo container
```bash
make sh-mongo
```
8. Enter to Rabbit container
```bash
make sh-rabbit
```
9. Enter to Node container
```bash
make sh-node
```
10. Enter to Mailhog container
```bash
make sh-mailhog
```