#!/bin/bash

dirs=$(find dry/* -type d)
for d in $dirs
do
    dir=${d#*/}
    hydrated_dir="hydrated/$dir"
    echo $dir
    rm hydrated/$dir/* 2> /dev/null
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
