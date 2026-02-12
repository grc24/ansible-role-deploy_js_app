ARG NODE_VERSION
FROM node:${NODE_VERSION}

# Install system dependencies
{% if 'alpine' in NODE_VERSION %}
RUN apk add --no-cache \
    openssl \
    libc6-compat
{% else %}
RUN apt-get update && apt-get install -y \
    openssl \
 && rm -rf /var/lib/apt/lists/*
{% endif %}

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
ARG PORT_INSIDE_CONTAINER
EXPOSE ${PORT_INSIDE_CONTAINER}

{% if 'prisma' in dependencies %}
# Set environment variable for Prisma and generate Prisma client ( Only for development environment )
ARG DATABASE_URL
ENV DATABASE_URL=${DATABASE_URL}
RUN npx prisma generate
CMD sh -c "npx prisma migrate deploy && npm run start"
{% else %}
CMD sh -c "npm run start"
{% endif %}


