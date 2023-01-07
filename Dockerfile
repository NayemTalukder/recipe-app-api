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
  django

# RUN whoami
# RUN su django
# RUN chmod u+rwx /app

ENV PATH="/py/bin:$PATH"
# RUN chown django app
# RUN chgrp django app 
# USER django
# RUN whoami
# RUN ls -l
# RUN pwd
# RUN chown root:django /app
# RUN chgrp django app 

RUN chown django app
RUN chgrp django app
# RUN ls -l
RUN chown django py/*/*
RUN chgrp django py/*/*


RUN chown django usr/local/bin/*
RUN chgrp django usr/local/bin/*

# RUN chown django python
# RUN chgrp django python

USER django

# RUN cd ..
# RUN ls -l

# RUN cut -d: -f1 /etc/passwd

# RUN cd py/bin && cat django-admin && ls -l
# RUN cd usr/local/bin && ls -l
# RUN  ls -l && cd..