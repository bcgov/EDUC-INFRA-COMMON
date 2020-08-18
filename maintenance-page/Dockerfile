# Dockerfile
FROM nginx:latest
RUN chmod g+rwx /var/cache/nginx /var/run /var/log/nginx
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./html .
EXPOSE 8080:8080
CMD ["nginx", "-g", "daemon off;"]
