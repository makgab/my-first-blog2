#
# Docker/Podman: Python, Django
#
#      podman build --tag python:django -f ./Dockerfile
#      podman run [-it] -p 80:80 --name django --hostname django python:django
#      podman container ls
#      podman exec -it containername /bin/bash
#      podman volume ls
#      podman container inspect containername
#
#      https://www.freedesktop.org/software/systemd/man/loginctl.html
#      loginctl enable-linger username
#


FROM python:latest

RUN mkdir /app
RUN apt update -y
RUN apt install mc -y

ADD . /app

WORKDIR /app

RUN pip3 install -r /app/requirements.txt

# EXPOSE
EXPOSE 8080

ENTRYPOINT ["python3", "manage.py", "runserver", "0:8080"]
