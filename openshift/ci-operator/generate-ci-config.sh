#!/bin/bash

branch=${1-'master'}

cat <<EOF
tag_specification:
  name: '4.0'
  namespace: ocp
promotion:
  cluster: https://api.ci.openshift.org
  namespace: openshift
  name: $branch
base_images:
  base:
    name: '4.0'
    namespace: ocp
    tag: base
build_root:
  project_image:
    dockerfile_path: openshift/ci-operator/build-image/Dockerfile
canonical_go_repository: github.com/knative/client
binary_build_commands: make build
tests:
- as: e2e
  commands: "make test-e2e"
  openshift_installer_src:
    cluster_profile: aws
resources:
  '*':
    limits:
      memory: 4Gi
    requests:
      cpu: 100m
      memory: 200Mi
EOF