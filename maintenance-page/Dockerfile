# Dockerfile
FROM nginx:latest
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./html /usr/share/nginx/html
EXPOSE 8080:8080
CMD ["nginx", "-g", "daemon off;"]
