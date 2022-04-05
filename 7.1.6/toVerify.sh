#!/bin/bash
### При слитие последнего MR по задаче необходимо переводить задачу в To Verify
### Пример: По задаче может быть несколько MR (в разных репозиториях например), так вот,
### когда мёрджится MR нужно проверять есть ли ещё MR по этой задаче и если нет то переводить статус задачи из On Review в To Verify

export USERNAME="gitlab"
export PASSWORD="yuRFxb1"
export HTTP_METHOD="GET"
#export BASE_URL="https://jira-test.sigma-it.ru"
export BASE_URL="https://jira.sigma-it.ru"
export API_NAME="rest/api/2"
export issueIdOrKey="CO-4027"
export API_METHOD="issue/${issueIdOrKey}/?fields=status"
export STATUS_REGEX='\"name\":\"Готов для проверки\"'

ISSUE_STATUS=`curl -s -u ${USERNAME}:${PASSWORD} -X ${HTTP_METHOD} ${BASE_URL}/${API_NAME}/${API_METHOD} | grep -o "${STATUS_REGEX}"`

if [ "${ISSUE_STATUS}X" != "X" ]
then
  echo "ISSUE_STATUS = ${ISSUE_STATUS}"
  echo "Changing status ..."
  export HTTP_METHOD="POST"
  export DATA='{"transition":{"id":"111"}}'
  export HEADER="Content-Type: application/json"
  export API_METHOD="issue/${issueIdOrKey}/transitions"
  curl -u ${USERNAME}:${PASSWORD} -X ${HTTP_METHOD} --data "${DATA}" -H "${HEADER}" ${BASE_URL}/${API_NAME}/${API_METHOD}
else
  echo "ISSUE_STATUS = ${ISSUE_STATUS}"
  echo "Change status skipped"
  exit 1
fi



