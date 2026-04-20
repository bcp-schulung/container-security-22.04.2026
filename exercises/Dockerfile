FROM nginx:1.29.6

# Remove default content
RUN rm -rf /usr/share/nginx/html/*

# Copy static site
COPY --chown=nginx:nginx index.html /usr/share/nginx/html/index.html

# Use a high port so nginx can run without extra privileges
RUN sed -i 's/listen       80;/listen       8080;/' /etc/nginx/conf.d/default.conf

# Fix PID path for non-root nginx
RUN sed -i '1i pid /tmp/nginx.pid;' /etc/nginx/nginx.conf

# Run as non-root
USER nginx

EXPOSE 8080

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]