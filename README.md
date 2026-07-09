# dynamic-react-app

This repo contains a dynamic React app.

## CI/CD

GitHub Actions workflow added: Build and push image to GCP Artifact Registry.

- Push a commit to master to trigger the build.
- Ensure GCP workload identity provider and service account secrets are set in GitHub.

