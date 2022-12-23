FROM python:3.9-alpine3.13
LABEL maintaner="Andressa Silva"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
    then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp
# addgroup -S \
# djangogroup && \
# adduser -S \
# --disabled-password \
# --no-create-home \
# djangouser \
# -G djangogroup
# RUN chown -R $(whoami):$(whoami) .
# RUN export UID=${UID} && export GID=${GID}

ENV PATH="/py/bin:$PATH"