FROM nginx:latest

RUN echo "The version is V1.0.0" >> /usr/share/nginx/html/index.html

CMD ["nginx", "-g", "daemon off;"]