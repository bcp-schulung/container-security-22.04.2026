FROM alpine:3.22

# Install nginx, openssl (for self-signed dev cert), and cert bundle
RUN apk add --no-cache nginx ca-certificates openssl && \
    update-ca-certificates && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /run/nginx /var/cache/nginx /var/log/nginx /var/lib/nginx/logs /etc/nginx/conf.d /etc/nginx/tls /srv/www && \
    chown -R nginx:nginx /run/nginx /var/cache/nginx /var/log/nginx /var/lib/nginx /srv/www /etc/nginx && \
    chmod 750 /run/nginx /var/cache/nginx /var/log/nginx /srv/www && \
    chmod 700 /etc/nginx/tls

# Remove the default site if present
RUN rm -f /etc/nginx/http.d/default.conf /etc/nginx/conf.d/default.conf || true

# Copy hardened configs
COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d/default.conf /etc/nginx/conf.d/default.conf

# Static site
COPY index.html /srv/www/index.html

# Generate a self-signed cert for development/testing
# In production, mount real certs as read-only secrets at /etc/nginx/tls/
RUN openssl req -x509 -newkey rsa:2048 -days 365 -nodes \
    -keyout /etc/nginx/tls/privkey.pem \
    -out /etc/nginx/tls/fullchain.pem \
    -subj "/CN=localhost" && \
    chmod 600 /etc/nginx/tls/privkey.pem /etc/nginx/tls/fullchain.pem && \
    chown nginx:nginx /etc/nginx/tls/privkey.pem /etc/nginx/tls/fullchain.pem

# Production: mount real certs as read-only secrets at /etc/nginx/tls/

# Validate configuration at build time, then fix ownership of any files nginx created as root
RUN nginx -t && chown -R nginx:nginx /var/log/nginx /var/lib/nginx /run/nginx

USER nginx:nginx

# Use high ports so the container does not need root
EXPOSE 8080 8443

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]