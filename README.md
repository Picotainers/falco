# falco

Container image for `falco` built from upstream release artifacts.

## Quick Usage

```bash
docker pull docker.io/picotainers/falco:latest
docker run --rm docker.io/picotainers/falco:latest --help
```

## Usage

```bash
# Run QC against a FASTQ file in the current directory
docker run --rm -v "$(pwd):/data" -w /data docker.io/picotainers/falco:latest -o output input.fastq.gz
```

## Building

```bash
docker build -t docker.io/picotainers/falco:latest .
```

## Quick Usage

```bash
# Pull the image
docker pull docker.io/picotainers/falcoatest

# Run the tool
docker run --rm docker.io/picotainers/falcoatest falco --help
```
