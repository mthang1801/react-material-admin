FROM node:16 as builder 
WORKDIR /usr/src/app 
COPY package.json . 
RUN npm install 
COPY . . 
RUN npm run build 

FROM nginx:latest as runner 
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}
WORKDIR /usr/src/app 
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80 
ENTRYPOINT ["nginx", "-g", "daemon off;"]