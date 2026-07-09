# syntax=docker/dockerfile:1
FROM node:20 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install --legacy-peer-deps
COPY . .
# Adjust build output directory based on the framework
# Here, assuming the app uses create-react-app; change to 'dist' or 'dist/<name>' if needed.
RUN npm run build

FROM nginx:1.27-alpine
# Use correct build directory; assuming React default 'build/'
COPY --from=builder /app/build /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
