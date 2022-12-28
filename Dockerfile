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

# from image
FROM python:latest

# run update
RUN mkdir /app
RUN apt update -y
RUN apt install bash mc -y

# add files
ADD . /app

# set working directory
WORKDIR /app

# requirements and init
RUN pip3 install -r /app/requirements.txt
RUN chmod 777 /app/init.sh
RUN /app/init.sh


# EXPOSE
EXPOSE 8080

# entrypoint
ENTRYPOINT ["python3", "manage.py", "runserver", "0:8080"]
