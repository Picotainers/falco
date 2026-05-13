# falco
Small compatibility-focused container for `falco`.

## how to use
```bash
docker run --rm -v "$(pwd):/data" picotainers/falco:latest --help
```

## Quick Usage

```bash
# Pull the image
docker pull docker.io/picotainers/falcoatest

# Run the tool
docker run --rm docker.io/picotainers/falcoatest falco --help
```
