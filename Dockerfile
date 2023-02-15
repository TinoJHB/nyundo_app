FROM openjdk:8-jdk-alpine

WORKDIR /app

RUN apk add --no-cache curl tar \
    && apk add --no-cache --virtual .build-deps \
        build-base \
        python3-dev \
        libffi-dev \
        openssl-dev \
    && apk add --no-cache --virtual .run-deps \
        python3 \
        openssl \
    && apk update apk add git
    
    # Install python/pip
    ENV PYTHONUNBUFFERED=1

RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

RUN curl https://bootstrap.pypa.io/pip/3.6/get-pip.py -o get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

# Install required packages using pip
RUN pip install cassandra-driver elasticsearch redis flask

# Copy the project files into the image
COPY . .

# Expose port 5000 to the host
EXPOSE 5000

# Run the application
CMD ["python3", "main.py"]
