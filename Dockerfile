# Use an official lightweight version of Ubuntu
FROM python:3.9-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Jerusalem

# Update packages and install necessary dependencies
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv curl dos2unix tzdata vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /inventory

# Copy your application code to the container
COPY . /inventory/
RUN mkdir -p /inventory/files

# Set up a Python virtual environment and install dependencies
RUN python3 -m venv venv
RUN . /inventory/venv/bin/activate && pip install --upgrade pip && pip install -r requirements.txt

COPY start.sh /start.sh
RUN dos2unix /start.sh
RUN chmod +x /start.sh

# Expose the Flask port
EXPOSE 5000

CMD ["bash", "/start.sh"]
