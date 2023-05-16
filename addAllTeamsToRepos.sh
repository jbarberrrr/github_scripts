#!/bin/bash

orgs=()

for org in ${orgs[@]}
do
	echo -e "Organization: $org"
	# Get a list of teams in the organizations
	curl -L \
	   -H "Accept: application/vnd.github+json" \
	   -H "Authorization: Bearer $TK_GH"\
	   -H "X-GitHub-Api-Version: 2022-11-28" \
	   https://api.github.com/orgs/$org/teams >> tmp1.txt
	# Process and store teams in "groups" array
	groups=()
	grep -oP '(?<="name": ").*?(?=",)' tmp1.txt >> tmp2.txt
	readarray groups < tmp2.txt
	echo "Groups in this Org: "
	echo -e ${groups[@]}
	echo ""
	rm tmp*
	for group in "${groups[@]}"
		do
		        group=$(echo $group | tr -d " ")
			then
			    echo ""
			    echo ""
			    echo -e "$group"
			    while read user
			      do
		        	curl -L \
			        -X PUT \
			        -H "Accept: application/vnd.github+json" \
			        -H "Authorization: Bearer $TK_GH"\
			        -H "X-GitHub-Api-Version: 2022-11-28" \
			        https://api.github.com/orgs/$org/teams/$group/memberships/$user
			      done < "$group.txt"
		done
done
