FROM node:18 as builder

WORKDIR /build
COPY package*.json .
RUN npm install

COPY src/ src/
COPY public/ public/

RUN npm run build

# FROM node:18 as runner
# WORKDIR /app

# COPY --from=builder build/package*.json .
# COPY --from=builder build/node_modules/ node_modules/
# COPY --from=builder build/build build/

# RUN npm 


FROM nginx:1.23-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=builder /build/build .
EXPOSE 80
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]