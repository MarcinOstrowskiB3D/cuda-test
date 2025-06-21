#!/usr/bin/env bash
set -euo pipefail

REPO=${GITHUB_REPOSITORY:-""}
TAG=${1:-"deploy-$(date +%Y%m%d%H%M%S)"}

if [ -z "$REPO" ]; then
    echo "GITHUB_REPOSITORY not set" >&2
    exit 1
fi

if [ -z "${DEPLOY_TOKEN:-}" ]; then
    echo "DEPLOY_TOKEN not set" >&2
    exit 1
fi

read -r -d '' DATA <<EOT
{
  "tag_name": "${TAG}",
  "name": "${TAG}",
  "body": "Automated deployment"
}
EOT

curl -X POST -H "Authorization: token ${DEPLOY_TOKEN}" \
    -H "Accept: application/vnd.github+json" \
    -d "$DATA" \
    "https://api.github.com/repos/${REPO}/releases"
