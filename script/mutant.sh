#!/bin/bash

set -euo pipefail
IFS=$'\t'

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${DIR}"
# End boilerplate

pushd ..

# Mutant is kind of hard to use.
# We grab all of the classes we want to test, and pass them to mutant.
grep -e '^\(RSpec.\)\?describe' -r spec | \
    awk '{print $2}' | \
    xargs -I {} bundle exec mutant --use rspec {}
