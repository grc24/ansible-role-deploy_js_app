ARG NODE_VERSION=18.20
FROM node:${NODE_VERSION}

WORKDIR /app

# Install dependencies
COPY package*.json ./

# Copy source
COPY . .

RUN npm install --legacy-peer-deps

{% if 'prisma' in dependencies %}
# Prisma
ARG DATABASE_URL
ENV DATABASE_URL=${DATABASE_URL}
RUN npx prisma generate
{% endif %}

# Build NestJS
RUN npm run build

ARG NODE_ENV=production
ARG PORT_INSIDE_CONTAINER=3000
ENV NODE_ENV=${NODE_ENV}
EXPOSE ${PORT_INSIDE_CONTAINER}

{% if  'prisma' in dependencies %}
CMD sh -c "npx prisma migrate deploy && npm run start:prod"
{% else %}
CMD [ "npm", "run", "start:prod" ]
{% endif %}