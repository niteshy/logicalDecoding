#!/bin/bash
#PGHOST='127.0.0.1'
#USPGUSERER='postgres'
#PGDATABASE='testdb1'
#PGPASSWORD=''
#NINSERT=20000

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
  start=$(getCount "SELECT MAX(id) FROM table1;")
  echo "Number of existing rows: ${start}"

  for (( i=$(( $start + 1 )); i < $(( $start + $NINSERT )); i++ ))
  do
    columns="username, password, email, created_on, last_login, mybool, mynumeric, mysmall, myint, mybigint, mydate, mytime, myts, mytsz,col1, col2, col3, col4, col5, col6, col7, col8, col9, col10, col11, col12, col13, col14, col15, col16, col17, col18, col19, col20, col21, col22, col23, col24, col25, col26, col27, col28, col29, col30, col31, col32, col33, col34, col35, col36, col37, col38, col39, col40, col41, col42, col43, col44, col45, col46, col47, col48, col49, col50, col51, col52, col53, col54, col55, col56, col57, col58, col59, col60, col61, col62, col63, col64, col65, col66, col67, col68, col69, col70, col71, col72, col73, col74, col75, col76, col77, col78, col79, col80, col81, col82, col83, col84, col85, col86, col87, col88, col89, col90, col91, col92, col93, col94, col95, col96, col97, col98, col99, col100"
    values="'name$i', 'pass$i', 'email$i@gmail.com', current_timestamp, current_timestamp, 't', $i, $i, 1$i, 2$i, current_timestamp, current_timestamp, current_timestamp, current_timestamp, '`random-string 101 `', '`random-string 102 `', '`random-string 103 `', '`random-string 104 `', '`random-string 105 `', '`random-string 106 `', '`random-string 107 `', '`random-string 108 `', '`random-string 109 `', '`random-string 110 `', '`random-string 111 `', '`random-string 112 `', '`random-string 113 `', '`random-string 114 `', '`random-string 115 `', '`random-string 116 `', '`random-string 117 `', '`random-string 118 `', '`random-string 119 `', '`random-string 120 `', '`random-string 121 `', '`random-string 122 `', '`random-string 123 `', '`random-string 124 `', '`random-string 125 `', '`random-string 126 `', '`random-string 127 `', '`random-string 128 `', '`random-string 129 `', '`random-string 130 `', '`random-string 131 `', '`random-string 132 `', '`random-string 133 `', '`random-string 134 `', '`random-string 135 `', '`random-string 136 `', '`random-string 137 `', '`random-string 138 `', '`random-string 139 `', '`random-string 140 `', '`random-string 141 `', '`random-string 142 `', '`random-string 143 `', '`random-string 144 `', '`random-string 145 `', '`random-string 146 `', '`random-string 147 `', '`random-string 148 `', '`random-string 149 `', '`random-string 150 `', '`random-string 151 `', '`random-string 152 `', '`random-string 153 `', '`random-string 154 `', '`random-string 155 `', '`random-string 156 `', '`random-string 157 `', '`random-string 158 `', '`random-string 159 `', '`random-string 160 `', '`random-string 161 `', '`random-string 162 `', '`random-string 163 `', '`random-string 164 `', '`random-string 165 `', '`random-string 166 `', '`random-string 167 `', '`random-string 168 `', '`random-string 169 `', '`random-string 170 `', '`random-string 171 `', '`random-string 172 `', '`random-string 173 `', '`random-string 174 `', '`random-string 175 `', '`random-string 176 `', '`random-string 177 `', '`random-string 178 `', '`random-string 179 `', '`random-string 180 `', '`random-string 181 `', '`random-string 182 `', '`random-string 183 `', '`random-string 184 `', '`random-string 185 `', '`random-string 186 `', '`random-string 187 `', '`random-string 188 `', '`random-string 189 `', '`random-string 190 `', '`random-string 191 `', '`random-string 192 `', '`random-string 193 `', '`random-string 194 `', '`random-string 195 `', '`random-string 196 `', '`random-string 197 `', '`random-string 198 `', '`random-string 199 `', '`random-string 200`'";
    insertSQL="INSERT INTO table1 (${columns}) VALUES ($values);";
    updateSQL="UPDATE table1 SET username = 'changedname$i', email = 'changedemail$i@gmail.com' WHERE username = 'name$i';";
    deleteSQL="DELETE FROM table1 WHERE username = 'changedname$i';";
    #echo ${insertSQL};
    executeSQL "${insertSQL}";
    #echo ${updateSQL};
    executeSQL "${updateSQL}";
    #echo ${deleteSQL};
    executeSQL "${deleteSQL}";
  done
  echo "done"
}

main