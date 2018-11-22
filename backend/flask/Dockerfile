FROM python:3.7-alpine AS base

LABEL maintainer="Dat Nguyen <hi@dat.works>"
RUN mkdir -p /app
WORKDIR /app

COPY requirements.txt /app
RUN pip install --no-cache-dir -r requirements.txt
COPY . /app