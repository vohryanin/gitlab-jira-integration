#!/bin/bash
### При нажатии Approve в MR необходимо назначить исполнителем задачи того разработчика, кто делал MR и добавить комментарий в задачу "Проверено, можно сливать" (Только для задач с компонентом Front)
### Пример: У задачи есть исполнитель Иванов Иван, он сделал задачу и перевёл её в "On Review", создал MR по ветке этой задачи и отдал его лиду, лид проверил и нажал в MR approved
### и тогда в задаче должен измениться исполнитель на того который задаче в On Review переводил и должен оставиться комментарий в задачи от
### системного пользователя с текстом "Проверено, можно сливать" - Помощь в получение системного пользователя, объяснения как получить резолюции и как работает флоу можно обращаться к Шорникова Алевтина Игоревна.
### ВНИМАНИЕ! Данная настройка должна быть только у задач с полем Components: Front

export USERNAME="gitlab"
export PASSWORD="yuRFxb1"
export HTTP_METHOD="GET"
#export BASE_URL="https://jira-test.sigma-it.ru"
export BASE_URL="https://jira.sigma-it.ru"
export API_NAME="rest/api/2"
export issueIdOrKey="CO-4027"
export API_METHOD="issue/${issueIdOrKey}/?fields=components"
export REGEX='\"name\":\"Front\"'

ISSUE_COMPONENTS=`curl -s -u ${USERNAME}:${PASSWORD} -X ${HTTP_METHOD} ${BASE_URL}/${API_NAME}/${API_METHOD} | grep -o "${REGEX}"`

if [ "${ISSUE_COMPONENTS}X" != "X" ]
then
  echo "ISSUE_COMPONENTS = ${ISSUE_COMPONENTS}"
  ### Добавляем коммент
  echo "Adding comment ..."
  export HTTP_METHOD="POST"
  export DATA='{
                   "body": "Проверено, можно сливать."
               }'
  export HEADER="Content-Type: application/json"
  export API_METHOD="issue/${issueIdOrKey}/comment"
  curl -u ${USERNAME}:${PASSWORD} -X ${HTTP_METHOD} --data "${DATA}" -H "${HEADER}" ${BASE_URL}/${API_NAME}/${API_METHOD}

  ### Меняем исполнителя
  echo
  echo "Setting assignee..."
  export ASSIGNEE="gitlab"
  export HTTP_METHOD="PUT"
  export DATA="{
                     \"name\": \"${ASSIGNEE}\"
                 }"
  export API_METHOD="issue/${issueIdOrKey}/assignee"
  curl -u ${USERNAME}:${PASSWORD} -X ${HTTP_METHOD} --data "${DATA}" -H "${HEADER}" ${BASE_URL}/${API_NAME}/${API_METHOD}
else
  echo "ISSUE_COMPONENTS = ${ISSUE_COMPONENTS}"
  echo "Adding comment"
  exit 1
fi