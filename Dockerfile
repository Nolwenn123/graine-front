# Étape 1 : Utiliser une image Node.js pour la construction
FROM node:18 AS build

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier les fichiers package.json et package-lock.json
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier le reste du projet
COPY . .

# Compiler le projet Angular
RUN npm run build --prod

# Étape 2 : Utiliser une image NGINX pour servir l'application
FROM nginx:alpine

# Copier les fichiers compilés dans le répertoire par défaut de NGINX
COPY --from=build /app/dist/graine-front /usr/share/nginx/html

# Exposer le port 80 pour le serveur NGINX
EXPOSE 80

# Commande par défaut pour lancer NGINX
CMD ["nginx", "-g", "daemon off;"]
