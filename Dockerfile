FROM nginx:latest

RUN echo "The version is 1.0.1" >> /usr/share/nginx/html/index.html

CMD ["nginx", "-g", "daemon off;"]