#!/bin/bash

# Start Nginx in the background
service nginx start

# Activate the virtual environment
. /inventory/venv/bin/activate

# Run the Flask app using Gunicorn (app:app refers to the 'app' object in the 'app.py' file)
exec gunicorn inventory:inventory --bind 0.0.0.0:5001


