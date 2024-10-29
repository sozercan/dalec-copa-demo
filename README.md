# dalec-copa-demo

[Copa](https://github.com/project-copacetic/copacetic) can do an amazing job patching OS level vulnerabilities, using packages in containers. One of the top feedback we heard from copa users was request for addressing app level vulnerabilities. This means code in applications and their dependencies, and recompiling applications to use patched versions of dependencies.

In this demo, we will show how to use [Dalec](https://github.com/Azure/dalec) to address application level vulnerabilities, and [Copa](https://github.com/project-copacetic/copacetic) to patch both OS and application level vulnerabilities.

## Recording

You can watch the recording of the demo [here](https://asciinema.org/a/aM9sx9dSzbvZMaHgCwJaDeDjx).

## Prerequisites

Make sure you have the following tools installed on your machine and available in your PATH:
- [Copa](https://github.com/project-copacetic/copacetic) [v0.9.0](https://github.com/project-copacetic/copacetic/releases/tag/v0.9.0) or later
- [Trivy](https://github.com/aquasecurity/trivy)
- [Docker](https://docs.docker.com/engine/install/)
- [yq](https://github.com/mikefarah/yq)
- GNU/Linux tools such as awk, sed, grep, cat

## How to run the demo

- Clone this repository

```shell
git clone https://github.com/sozercan/dalec-copa-demo.git
```

- Change directory to the repository

```shell
cd dalec-copa-demo
```

- Run the demo

```shell
./demo.sh
```

## Dependabot

[Dependabot](https://docs.github.com/en/code-security/getting-started/dependabot-quickstart-guide) is a tool that helps you keep your dependencies up to date. This includes copa patched images used in Dockerfiles, Kubernetes manifests, and Helm charts.

Example: https://github.com/sozercan/dependabot-test/pull/1
