FROM centos:centos7

LABEL maintainer="andrew.urwin@devopsgroup.com"

# Install Node.js and npm (from NodeSource repo for latest versions)
RUN yum -y update && yum clean all && \
    yum -y install curl epel-release && yum clean all && \
    curl -sL https://rpm.nodesource.com/setup_14.x | bash - && \
    yum -y install nodejs && yum clean all

# Set working directory inside container
WORKDIR /src

# Copy package.json and package-lock.json first for better caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port your app runs on
EXPOSE 8888

# Start the application
CMD ["node", "app.js"]
