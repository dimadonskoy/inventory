# Use an official lightweight version of Ubuntu
FROM python:3.9-slim

# Set environment variables to prevent interactive prompts during builds
ENV DEBIAN_FRONTEND=noninteractive

# Update packages and install necessary dependencies
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv nginx-core curl dos2unix tzdata vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV TZ=Asia/Jerusalem


# Set the working directory inside the container
WORKDIR /inventory

# Copy your application code to the container
COPY  . /inventory/
RUN mkdir -p /inventory/files

# Set up a Python virtual environment and install dependencies
RUN python3 -m venv venv
RUN . /inventory/venv/bin/activate && pip install --upgrade pip && pip install -r requirements.txt

# Remove the default Nginx config
RUN rm /etc/nginx/sites-enabled/default

# Copy your custom Nginx configuration
COPY nginx.conf /etc/nginx/sites-available/default
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# Expose the ports for Nginx and Flask
EXPOSE 80 5000

RUN apt-get update && apt-get install -y dos2unix
COPY start.sh /start.sh
RUN dos2unix /start.sh
RUN chmod +x /start.sh

# Define the command to run your app
CMD ["bash", "/start.sh"]
