#!/bin/bash

if [[ $# -ne 2 ]]; then
	echo "This script requires a org name as the first param and teams/repos as the second."
	exit 1
fi

gh api \
	-H "Accept: application/vnd.github+json" \
	-H "Authorization: Bearer $TK_GH"\
	-H "X-GitHub-Api-Version: 2022-11-28" \
	/orgs/$1/$2 >> temp.txt 

jq ".[].name" temp.txt
rm temp.txt
