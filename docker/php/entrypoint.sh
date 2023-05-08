#!/usr/bin/env sh

if id "user"  >/dev/null 2>&1; then
  echo "User exist"
else
  groupadd -g 1000 user
  useradd -u 1000 -m -g user -s /bin/bash user
fi

if [ ! -d /home/user ]; then
 mkdir /home/user
 chown user:user /home/user
fi
exec "$@";