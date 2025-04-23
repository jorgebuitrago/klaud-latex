FROM blang/latex:ubuntu

# Install Python 3 and AWS CLI
RUN apt-get update && \
    apt-get install -y python3-pip && \
    pip3 install awscli && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /var/task

# Copy handler script
COPY app.py .

# Define the Lambda handler
CMD ["app.lambda_handler"]