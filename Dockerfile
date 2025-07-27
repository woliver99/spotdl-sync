# Use a slim Python base image
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

# Install ffmpeg, which is required by spotdl for audio conversion
RUN apt-get update && apt-get install -y ffmpeg

# Install spotdl
RUN pip install spotdl

# Copy the sync script into the container
COPY sync.sh .

# Make the script executable
RUN chmod +x sync.sh

# This command will run when the container starts
CMD ["./sync.sh"]
