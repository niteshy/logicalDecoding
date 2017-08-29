#!/bin/bash
#PGHOST='127.0.0.1'
#USPGUSERER='postgres'
#PGDATABASE='testdb1'
#PGPASSWORD=''
#NINSERT=20

function getCount {
  id=`PGPASSWORD=${PGPASSWORD} psql -U${PGUSER} -p${PGDATABASE} -d ${PGDATABASE} -h ${PGHOST} -p 5432 -t -w -c "$1"`;
  #if [[ $id = *[!\ ]* ]]; then
  if [[ -z "${id// }" ]]; then
    echo '0';
  else
    echo $(echo $id |  cut -d' ' -f 3)
  fi
}

function executeSQL {
  id=`PGPASSWORD=${PGPASSWORD} psql -U${PGUSER} -p${PGDATABASE} -d ${PGDATABASE} -h ${PGHOST} -p 5432 -t -w -c "$1"`;
  echo $id
}

function random-string {
    cat /dev/urandom | env LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1
}

function main {
  start=$(getCount "SELECT MAX(id) FROM table2;")
  echo "Number of existing rows: ${start}"

  for (( i=$(( $start + 1 )); i < $(( $start + $NINSERT )); i++ ))
  do
    columns="ID,NAME,AGE,ADDRESS,SALARY,JOIN_DATE"
    values="$i, 'Paul$i', 20 + $i, 'California$i', 20000, current_timestamp";
    insertSQL="INSERT INTO table2 (${columns}) VALUES ($values);";
    echo ${insertSQL};
    executeSQL "${insertSQL}";

    updateSQL="UPDATE table2 SET NAME = 'Sam$i', ADDRESS = 'New York$i' WHERE ID = $i;";
    echo ${updateSQL};
#    executeSQL "${updateSQL}";

    deleteSQL="DELETE FROM table2 WHERE ID = $i;";
    echo ${deleteSQL};
#    executeSQL "${deleteSQL}";
  done
  echo "done"
}

main