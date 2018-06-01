FROM node:8.11.2 as node
LABEL athor="test thoi"
WORKDIR /app
COPY . .
RUN npm i npm@latest -g 
RUN npm install
ARG env=prod
RUN npm run build

FROM nginx:alpine AS webapp
LABEL name="app1"
VOLUME /var/cache/nginx
COPY --from=node /app/dist /usr/share/nginx/html

FROM webapp
WORKDIR /usr/share/nginx/html
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]