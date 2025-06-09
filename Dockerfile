  ## Use official Node.js LTS image
FROM node:18

# Create app directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install app dependencies
RUN npm install

# Copy app source code
COPY . .

# Expose port (your app port, e.g., 3000)
EXPOSE 3000

# Run the app
CMD ["node", "app.js"]
