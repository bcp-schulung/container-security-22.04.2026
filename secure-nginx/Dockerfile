FROM alpine:3.22

# Install nginx and cert bundle for OCSP/upstream TLS verification
RUN apk add --no-cache nginx ca-certificates && \
    update-ca-certificates && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /run/nginx /var/cache/nginx /var/log/nginx /etc/nginx/conf.d /etc/nginx/tls /srv/www && \
    chown -R nginx:nginx /run/nginx /var/cache/nginx /var/log/nginx /srv/www /etc/nginx && \
    chmod 750 /run/nginx /var/cache/nginx /var/log/nginx /srv/www && \
    chmod 700 /etc/nginx/tls

# Remove the default site if present
RUN rm -f /etc/nginx/http.d/default.conf /etc/nginx/conf.d/default.conf || true

# Copy hardened configs
COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d/default.conf /etc/nginx/conf.d/default.conf

# Optional: static site
# COPY html/ /srv/www/

# Optional: copy certs if you terminate TLS in the container
# Better for production: mount them at runtime as read-only secrets
# COPY tls/fullchain.pem /etc/nginx/tls/fullchain.pem
# COPY tls/privkey.pem   /etc/nginx/tls/privkey.pem
# RUN chmod 600 /etc/nginx/tls/* && chown nginx:nginx /etc/nginx/tls/*

# Validate configuration at build time
RUN nginx -t

USER nginx:nginx

# Use high ports so the container does not need root
EXPOSE 8080 8443

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]