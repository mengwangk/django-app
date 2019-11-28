import os
import django

os.environ['DJANGO_SETTINGS_MODULE'] = 'backend.settings'
django.setup()
 
DJANGO_DB_NAME = os.environ.get('DJANGO_DB_NAME', "default")
DJANGO_SU_NAME = os.environ.get('DJANGO_SU_NAME')
DJANGO_SU_EMAIL = os.environ.get('DJANGO_SU_EMAIL')
DJANGO_SU_PASSWORD = os.environ.get('DJANGO_SU_PASSWORD')

from django.contrib.auth.management.commands.createsuperuser import get_user_model
if get_user_model().objects.filter(username=DJANGO_SU_NAME): 
    print("Super user already exists. SKIPPING...")
else:
    print("Creating super user...")
    get_user_model()._default_manager.db_manager(DJANGO_DB_NAME).create_superuser(username=DJANGO_SU_NAME, email=DJANGO_SU_EMAIL, password=DJANGO_SU_PASSWORD)
    print("Super user created...")