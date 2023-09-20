#!/bin/bash

DRY_RUN=false
if [[ "$5" == "--dry" ]]; then
    DRY_RUN=true
fi

prevRelease=$1 # e.g. "140"
release=$2 # e.g. "141"
basePath=$3 # /Users/<username>/Projects
credentials=$4 # base64 of "firstname.lastname@inter.ikea.com:API-key"

function retrieve_merged_issues() {
    local dir="$1"
    local prevRelease="$2"
    local release="$3"
    local issues=""

    cd "$dir" || exit
    git fetch origin "release/$prevRelease" > /dev/null 2>&1
    git fetch origin "release/$release" > /dev/null 2>&1
    issues=$(git log --perl-regexp --author='^((?!dependabot\[bot\]).*)$' origin/release/"$prevRelease"..origin/release/"$release" | grep --text -Eo -w  "(ICA|IC|IECSD|IMECQT)-[0-9]{4}" | sort -u | sed 's/^/ https:\/\/ikeamvecom.atlassian.net\/rest\/api\/2\/issue\//')
    echo "$issues"
    cd - > /dev/null || exit
}

function add_label() {
    local url="$1"
    local release="$2"
    local auth="$3"

    curl --location --request PUT "$url" \
    --header "Content-Type: application/json" \
    --header "Authorization: Basic $auth" \
    --data '{
        "update": {
            "labels": [
                {
                    "add": "R'"$release"'"
                }
            ]
        }
    }'
}

all_issues=""

for repo in "ROSS-MVEcom-FE-Configuration-Checkout" "ROSS-MVEcom-Frontend"; do
    all_issues+=$(retrieve_merged_issues "$basePath/$repo" "$prevRelease" "$release")
    all_issues+=$"\n"
done

echo "$all_issues" | sort -u | while read -r line; do
    if $DRY_RUN; then
        modified_line="${line//https:\/\/ikeamvecom.atlassian.net\/rest\/api\/2\/issue\//}"
        echo "${modified_line//\$/}"
    else
        add_label "$line" "$release" "$credentials"
    fi
done


