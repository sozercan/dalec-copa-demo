#!/bin/bash

. demo-magic/demo-magic.sh

clear

# source policy is required since Azure Linux 3 cloud-native repo is not enabled by default
export EXPERIMENTAL_BUILDKIT_SOURCE_POLICY=source-policy.json

echo "==== Let's look at what our Dalec spec looks like ===="
pei "cat gatekeeper-3.17.1-1.yml"

echo "==== Building a container image with Dalec ===="
pei "docker build . -t gatekeeper:v3.17.1-1 -f gatekeeper-3.17.1-1.yml --target azlinux3/container"

# will return vulns in openssl-libs and opa as of this point in time
echo "==== Let's scan the image with Trivy ===="
pei "trivy image gatekeeper:v3.17.1-1"

echo "==== Note that the image has vulnerabilities in openssl-libs and opa ===="

echo "==== Here is the patch that bumps opa from 0.67 to 0.68 ===="
pei "cat patches/gk-3.17.1-opa-0.68.patch | grep -e github.com/open-policy-agent/opa | grep -e indirect"

# show the spec change to consume the file
echo "==== Here is the updated Dalec spec with the patch ===="
pei "yq e '.patches' gatekeeper-3.17.1-2.yml | sed '1s/^/patches:\n/'"

# we are now building a package with the patch applied
echo "==== Building a package with the patch applied ===="
pei "docker build . -f gatekeeper-3.17.1-2.yml --target azlinux3/rpm --output ."

# we can see that the package is built
echo "==== Here is the package that was built ===="
pei "ls -al RPMS/x86_64"

# in the interest of time, we are not going to push this package
# we already have the package in https://packages.microsoft.com/azurelinux/3.0/prod/cloud-native/x86_64/Packages/g/

echo "==== Copa can now patch the image with the new package to address both vulnerabilities ===="
pei "copa patch -i gatekeeper:v3.17.1-1 -t v3.17.1-2"

echo "==== Scanning the image with Trivy again ===="
pei "trivy image gatekeeper:v3.17.1-2"

echo "==== Note that the image is now free of vulnerabilities! ===="

# we can also bump these versions with the help of dependabot in our projects, such as in Dockerfiles, Kubernetes YAML files, or Helm charts
# example: https://github.com/sozercan/dependabot-test/pull/1
