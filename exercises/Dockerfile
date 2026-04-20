FROM nginx:1.29.6

# Remove default content
RUN rm -rf /usr/share/nginx/html/*

# Copy static site
COPY --chown=nginx:nginx index.html /usr/share/nginx/html/index.html

# Use a high port so nginx can run without extra privileges
RUN sed -i 's/listen       80;/listen       8080;/' /etc/nginx/conf.d/default.conf

# Fix PID path for non-root nginx
RUN sed -i 's|pid\s*/run/nginx.pid;|pid /tmp/nginx.pid;|' /etc/nginx/nginx.conf

# Pre-create cache dirs with correct ownership for non-root
RUN mkdir -p /var/cache/nginx/client_temp /var/cache/nginx/proxy_temp \
    /var/cache/nginx/fastcgi_temp /var/cache/nginx/uwsgi_temp /var/cache/nginx/scgi_temp \
    && chown -R nginx:nginx /var/cache/nginx

# Run as non-root
USER nginx

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/ || exit 1

EXPOSE 8080

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]