# Cloud Run bootstrap image

This directory contains the source for the generic bootstrap container image used when Terraform initially creates Cloud Run Jobs.

The image is intentionally trivial. Its only purpose is to provide a valid container image so that Terraform can create a Cloud Run Job before the corresponding application repository has deployed a real image.

## Ownership model

Terraform manages:

- the Artifact Registry repository
- the Cloud Run Job resource
- the Job's stable runtime configuration

Application repositories manage:

- building real application images
- pushing those images to Artifact Registry
- updating the Cloud Run Job's image reference

The bootstrap image is therefore not built by Terraform. It is a one-time bootstrap artifact built manually from the `Dockerfile` in this directory.

## Build

From this directory:

```bash
docker build -t cloud-run-bootstrap .
```

Test it locally:

```bash
docker run --rm cloud-run-bootstrap
```

Expected output:

```
default cloud run job
```

## Push to Artifact Registry

Authenticate Docker to Artifact Registry:

```bash
gcloud auth configure-docker europe-west1-docker.pkg.dev
```

Tag the local image with its full Artifact Registry name:

```bash
docker tag \
  cloud-run-bootstrap \
  europe-west1-docker.pkg.dev/railway-analytics-508615/railway-containers/cloud-run-bootstrap:bootstrap
```

Push it:

```bash
docker push \
  europe-west1-docker.pkg.dev/railway-analytics-508615/railway-containers/cloud-run-bootstrap:bootstrap
```

After pushing, obtain the immutable image digest from Artifact Registry.

The platform Terraform configuration should reference the bootstrap image by digest rather than by its mutable tag.

Once an application repository deploys a real image, application CI/CD owns subsequent changes to the Cloud Run Job's image field.