FROM alpine:latest

RUN apk add --no-cache python3 py3-pip bash

ADD ./webapp/requirements.txt /tmp/requirements.txt

# Créer un venv
RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

# Installer les dépendances dans le venv
RUN pip install --no-cache-dir -r /tmp/requirements.txt

ADD ./webapp /opt/webapp/
WORKDIR /opt/webapp

RUN adduser -D myuser
USER myuser

CMD gunicorn --bind 0.0.0.0:$PORT wsgi
