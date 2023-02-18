FROM openjdk:8-jdk-alpine

ENV SPARK_VERSION 2.4.0
ENV HADOOP_VERSION 2.7

# Install python
RUN apk add --update python python-dev py-pip && \
    apk add --update build-base && \
    pip install --upgrade pip && \
    pip install --upgrade virtualenv && \
    rm -rf /var/cache/apk/*

# Set work directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Download Spark and untar it
RUN wget https://archive.apache.org/dist/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz && \
    tar -xzf spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz && \
    rm spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz && \
    mv spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION /spark && \
    ln -s /spark/bin/pyspark /usr/bin/pyspark

# Start the app
CMD ["pyspark", "main.py"]
