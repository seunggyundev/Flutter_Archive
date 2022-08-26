FROM nginx

RUN mkdir /app
WORKDIR /app

RUN mkdir ./build
ADD ./build/web ./build

# meta data 변경 (필요 시에만)
COPY ./meta_data/ /app/build/web

RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/conf.d

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]