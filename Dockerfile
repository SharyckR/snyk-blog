# Use an official Node.js runtime as a parent image
FROM node:22.1-bookworm-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Install necessary libraries and update existing ones for resolve vulnerabilities
RUN apt-get update && \
    apt-get install -y zlib1g-dev tar libc6 systemd passwd perl libgcrypt20 libpam0g libncurses5 libncursesw5 gnutls-bin util-linux coreutils gnupg2 apt gcc && \
    apt-get upgrade -y && \
    apt-get clean

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install app dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Define the command to run the application
CMD ["npm", "start"]
