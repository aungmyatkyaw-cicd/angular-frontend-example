# Stage 1: Build an Angular Docker Image
FROM node:16.20.2-alpine as build
WORKDIR /app
COPY package*.json .npmrc ./
RUN npm install
COPY . .
RUN npm run build -- --prod --output-path=./dist/out

# Stage 2, use the compiled app, ready for production with Nginx
FROM nginx:alpine
LABEL maintainer="Aung Myat Kyaw <aungmyatkyaw.kk@gmail.com>"
COPY --from=build /app/dist/out/ /usr/share/nginx/html
COPY /nginx-custom.conf /etc/nginx/conf.d/default.conf
COPY env.sh /docker-entrypoint.d/env.sh
RUN chmod a+x /docker-entrypoint.d/env.sh
