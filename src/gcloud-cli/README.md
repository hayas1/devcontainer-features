
# gcloud-cli (gcloud-cli)

Install [gcloud-cli](https://cloud.google.com/sdk/gcloud) with [kubectl](https://github.com/kubernetes/kubectl) and [helm](https://github.com/helm/helm) (optional)

## Example Usage

```json
"features": {
    "ghcr.io/hayas1/devcontainer-features/gcloud-cli:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | install version of gcloud-cli | string | latest |
| with-kubectl | install version of kubectl or none | string | none |
| with-helm | install version of helm or none | string | none |
| completion | completion setting for selected shell | string | zsh |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/hayas1/devcontainer-features/blob/main/src/gcloud-cli/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
