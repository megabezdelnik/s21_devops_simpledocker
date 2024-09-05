FROM nginx


COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY server.c ./server.c
COPY build.sh ./build.sh

RUN chmod +x build.sh && bash build.sh

RUN chmod u-s /usr/bin/gpasswd; \
    chmod u-s /usr/bin/newgrp; \
    chmod u-s /bin/su; \
    chmod u-s /bin/mount; \
    chmod u-s /bin/umount; \
    chmod u-s /usr/bin/chsh; \
    chmod u-s /usr/bin/chfn; \
    chmod u-s /usr/bin/chsh; \
    chmod 255 /usr/bin/expiry; \
    chmod 255 /usr/bin/wall; \
    chmod 255 /sbin/unix_chkpwd; \
    chmod 255 /usr/bin/chage; \
    chmod 755 /usr/bin/passwd; \
    mkdir -p /var/cache/nginx/client_temp /var/cache/nginx/proxy_temp /var/cache/nginx/fastcgi_temp /var/cache/nginx/uwsgi_temp /var/cache/nginx/scgi_temp; \
    chmod 700 /var/cache/nginx; \
    chown -R nginx:nginx /var/cache/nginx; \
    mkdir -p /run; \
    chown -R nginx:nginx /run; \
    chmod -R 755 /run

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3  CMD [ "ps aux | grep spawn-fcgi || exit 1" ]

USER nginx
ENTRYPOINT nginx && spawn-fcgi -p 8080 -n ./server

EXPOSE 81