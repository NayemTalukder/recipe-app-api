FROM python:3.9-alpine3.13
LABEL maintainer='https://github.com/NayemTalukder'

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
EXPOSE 8080

ARG DEV=false
RUN python -m venv /py && \
  /py/bin/pip install --upgrade pip && \
  /py/bin/pip install -r /tmp/requirements.txt && \
  if [ $DEV = "true" ]; \
  then /py/bin/pip install -r /tmp/requirements.dev.txt; \
  fi && \
  rm -rf /tmp && \
  adduser \
  --disabled-password \
  --no-create-home \
  django-user

# RUN chown user:django-user -R /app/
# RUN chmod +x /app

ENV PATH="/py/bin:$PATH"

USER django-user
