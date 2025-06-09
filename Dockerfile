FROM node:18

# Set working directory
WORKDIR /usr/src/app

# Copy only package.json and package-lock.json first
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of your application
COPY . .

# Expose your app port
EXPOSE 3000

# Start the app
CMD ["node", "index.js"]
