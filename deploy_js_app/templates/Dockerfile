# Étape 1: Utilisation de l'image Node.js officielle
ARG NODE_VERSION
FROM node:${NODE_VERSION}

# Définition du répertoire de travail dans le conteneur
WORKDIR /app

# Copie des fichiers package.json et package-lock.json
COPY package*.json ./

# Installation des dépendances
RUN npm install

# Copie du reste des fichiers du projet
COPY . .

ARG PORT_INSIDE_CONTAINER
# Exposer le port utilisé par AdonisJS
EXPOSE ${PORT_INSIDE_CONTAINER}

# Commande pour démarrer l'application
CMD ["npm", "run", "dev"]
