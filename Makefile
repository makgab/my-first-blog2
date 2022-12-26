#
# podman, docker
#


#
# variables:
#
APP = python3 manage.py runserver
IMAGE = blog-django


# ------------------------------------------------------------------------------------------
# targets:
#
build:
	echo "No need build in Python :)"

run:
	$(APP)

clean:
	echo "No need clean in Python :)"

# Docker-specific targets
local-docker-build:
	podman build -t localhost/$(IMAGE):dev .

local-docker-run:
	podman run --rm localhost/$(IMAGE):dev

# GCloud-specific targets
gcloud-docker-init:
	gcloud auth configure-docker

gcloud-docker-build:
	docker build -t gcr.io/$(GCP_PROJECT_ID)/$(IMAGE):$(ENVIRONMENT) .

gcloud-docker-push:
	docker push gcr.io/$(GCP_PROJECT_ID)/$(IMAGE):$(ENVIRONMENT)

gcloud-run-deploy:
	gcloud run deploy $(APP)-$(ENVIRONMENT) \
	--region europe-west2 \
	--image gcr.io/$(GCP_PROJECT_ID)/$(IMAGE):$(ENVIRONMENT) \
	--port 80 \
	--project $(GCP_PROJECT_ID) \
	--max-instances 1 \
	--platform managed \
	--labels environment=$(ENVIRONMENT) \
	--allow-unauthenticated 

