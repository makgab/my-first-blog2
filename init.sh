#!/bin/bash
#
# blog django app init DB
#

# init DB
python3 manage.py makemigrations
python3 manage.py migrate
python3 manage.py migrate blog

# createsuperuser
python3 manage.py shell -c "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'adminpass')"


# run :)
