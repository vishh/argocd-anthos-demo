#!/bin/bash

dirs=$(find dry/* -type d)
hydrated_base_dir="hydrated"
rm -rf $hydrated_base_dir/
for d in $dirs
do
    dir=${d#*/}
    hydrated_dir="$hydrated_base_dir/$dir"
    mkdir -p $hydrated_dir
    if [ -f "$d/kustomization.yaml" ]
    then
	echo "found $d/kustomization.yaml"
	echo "kubectl kustomize build $d"
	kubectl kustomize $d > $hydrated_dir/configs.yaml
    elif ls -1qA $d/ | grep -q .
    then
	cp $d/* $hydrated_dir/
    fi
done
