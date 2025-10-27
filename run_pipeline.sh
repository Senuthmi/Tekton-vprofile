#!/bin/bash

echo "Starting Tekton PipelineRun..."

kubectl create -f - <<EOF
apiVersion: tekton.dev/v1
kind: PipelineRun
metadata:
  generateName: vprofile-run-
spec:
  pipelineRef:
    name: vprofile-ci-pipeline
  params:
    - name: repo-url
      value: https://github.com/Senuthmi/my-vprofile-project
    - name: git-revision
      value: main
    - name: image-registry
      value: docker.io/thimansa
    - name: image-tag
      value: v1.0.0
    - name: argocd-password
      value: jILDCSedEljdoAPr
    - name: argocd-app-name
      value: vprofile
    - name: git-username
      value: Senuthmi
    - name: git-email
      value: tsenuthmi2007@gmail.com
    - name: git-branch
      value: main
    - name: argocd-server
      value: argocd-server.argocd.svc.cluster.local
    - name: gitToken
      value: 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

  workspaces:
    - name: shared-workspace
      persistentVolumeClaim:
        claimName: shared-workspace-pvc
EOF
