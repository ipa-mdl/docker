#!/bin/bash

for f in $(find "$@" -name Dockerfile); do
    d="${f%/Dockerfile}"
    tag=$(basename "$d")
    repo=${d%/$tag}
    t="rosindustrial/${repo//\//-}:$tag" # replace other slashed with dashes
    echo
    echo "Build image $t"
    while sleep 9m; do echo "Still building $t..."; done &
    time docker build -q -t "$t" "$d" || ret=$?
    kill %%
done
exit $ret
