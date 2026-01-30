# Use the official Python image from the Docker Hub
FROM python:3.10-alpine

# Set the working directory in the container
#WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code into the container
COPY ./src /src

# Expose port 5000
EXPOSE 5000

# Run the application
CMD ["python", "/src/app.py"]