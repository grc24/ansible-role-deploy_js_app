# Étape 1: Utilisation de l'image Node.js officielle
FROM node:18-alpine

# Définition du répertoire de travail dans le conteneur
WORKDIR /app

# Copie des fichiers package.json et package-lock.json
COPY package*.json ./

# Installation des dépendances
RUN npm install

# Copie du reste des fichiers du projet
COPY . .

# Exposer le port utilisé par AdonisJS
EXPOSE 3333

# Commande pour démarrer l'application
CMD ["npm", "run", "dev"]
