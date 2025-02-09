#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Nho Luong
#  Date: 2023-06-02 01:29:52 +0100 (Fri, 02 Jun 2023)
#
#  https://github.com/nholuongut/template-repo
#
#  License: see accompanying nholuongut LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/nholuong
#

# Replaces references in this repo with the new name of your choice
#
# The delete this script in the new templated repo and carry on

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "$srcdir"

if [ $# -ne 1 ]; then
    echo "usage: <new_repo_name>"
    exit 3
fi

repo="$1"

if uname -s | grep -q Darwin; then
    sed(){
        gsed "$@"
    }
fi

sed -i "s/- Template Repo$/- $repo/" README.md

sed -i "s/Template-Repo/$repo/gi" \
    README.md \
    Makefile \
    azure-pipelines.yml \
    bitbucket-pipelines.yml \
    sonar-project.properties \
    .github/workflows/*.y*ml

# can't commit without the submodules checked out
#
#   error: 'bash-tools' does not have a commit checked out
#   fatal: updating files failed
#
make init
