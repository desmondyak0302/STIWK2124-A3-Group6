# Stage 1: Build the Angular application
FROM node:22 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --configuration=production

# Stage 2: Serve with Nginx
FROM nginx:alpine
# Copy the custom config created above
COPY nginx.conf /etc/nginx/conf.d/default.conf
# Copy build files (check your dist folder - if there is a 'browser' folder inside, use the path below)
COPY --from=build /app/dist/STIWK2124-A2-Group6/browser /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]