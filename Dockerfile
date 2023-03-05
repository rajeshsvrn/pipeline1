FROM tiangolo/uvicorn-gunicorn-fastapi:python3.9

#COPY ./main.py /app/main.py

# Use an official Python runtime as a parent image
#FROM python:3.9-slim-buster

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY ./main.py /app/main.py

# Install any needed packages specified in requirements.txt
#RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["python", "main.py"]
