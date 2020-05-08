#!/bin/sh
set -e

RUN=$1
WORKING_DIR=$2
SEND_COMMENT=$3
GITHUB_TOKEN=$4
#FLAGS=$5

## functions

exit_code=0

send_comment() {
    comment="$1"
    echo "${comment}"
    if [ "${SEND_COMMENT}" = "true" ]; then
        payload=$(echo '{}' | jq --arg body "${comment}" '.body = $body')
	      comments_url=$(jq -r .pull_request.comments_url < "${GITHUB_EVENT_PATH}")
	      curl -s -S -H "Authorization: token ${GITHUB_TOKEN}" --header "Content-Type: application/json" --data "${payload}" "${comments_url}" > /dev/null
    fi
}

lgtm() {
    send_comment "LGTM :+1:"
}

fail() {
    send_comment "fail"
    exit_code=1
}

main() {
    cd "${GITHUB_WORKSPACE}/${WORKING_DIR}"
    case ${RUN} in
        "fail" )
            fail
            ;;
	      "lgtm" )
		        lgtm
		        ;;
	      * )
		        echo "Invalid command"
		        exit 1
    esac

    if [ ${exit_code} -ne 0 ]; then
	      echo "Check Failed!!"
    fi
    exit ${exit_code}
}

main
