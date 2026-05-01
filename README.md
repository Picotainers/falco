# falco

Container image for Falco built from upstream source.

## Quick Usage

```bash
docker pull docker.io/picotainers/falco:latest
docker run --rm docker.io/picotainers/falco:latest --help
```

## Usage

```bash
# Run QC against a FASTQ file in the current directory
docker run --rm -v "$(pwd):/data" -w /data docker.io/picotainers/falco:latest input.fastq.gz
```

## Building

```bash
docker build -t docker.io/picotainers/falco:latest .
```
