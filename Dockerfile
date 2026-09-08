# Stage 1: Build Markdown files to static HTML
FROM klakegg/hugo:0.111.3-ext-alpine AS builder
WORKDIR /src
COPY ./site /src
RUN hugo --minify

# Stage 2: Serve compiled assets with lightweight Nginx
FROM nginx:1.25-alpine
COPY --from=builder /src/public /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
