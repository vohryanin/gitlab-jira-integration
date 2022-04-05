#!/bin/bash
### Check status for "name":"To Do"
### https://jira-test.sigma-it.ru/rest/api/2/issue/CO-1/?fields=status
export USERNAME="gitlab"
export PASSWORD="yuRFxb1"
export HTTP_METHOD="GET"
export BASE_URL="https://jira-test.sigma-it.ru"
export API_NAME="rest/api/2"
export issueIdOrKey="CO-1"
export API_METHOD="issue/${issueIdOrKey}/?fields=components"
export STATUS_REGEX='\"name\":\"To Do\"'






#echo "curl -u ${USERNAME}:${PASSWORD} -X ${METHOD} --data \"${DATA}\" -H \"${HEADER}\" ${BASE_URL}/${API_NAME}/issue/CO-1/transitions"
#curl -u ${USERNAME}:${PASSWORD} -X ${HTTP_METHOD} --data "${DATA}" -H "${HEADER}" ${BASE_URL}/${API_NAME}/${API_METHOD}
#curl -u ${USERNAME}:${PASSWORD} -X ${HTTP_METHOD} -H "${HEADER}" ${BASE_URL}/${API_NAME}/${API_METHOD}
curl -s -u ${USERNAME}:${PASSWORD} -X ${HTTP_METHOD} ${BASE_URL}/${API_NAME}/${API_METHOD} | grep -o "${STATUS_REGEX}"
