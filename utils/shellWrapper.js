/**
 * Created by Nitesh on 19/07/17.
 */
var spawn = require('child_process').spawn;

var runner = spawn('/bin/sh',
                   [ '-c', process.argv[2] ],
                   {
                     env: Object.assign({}, process.env, {
                       PGHOST: process.env.PGHOST,
                       PGUSER: process.env.PGUSER,
                       PGDATABASE: process.env.PGDATABASE,
                       PGPASSWORD: process.env.PGPASSWORD,
                       NINSERT: process.env.NINSERT })
                   }).on('error', function (err) { console.error(`runner : ${err}`); });

runner.stdout.on('data', (data) => {
  console.log(`stdout: ${data}`);
});

runner.stderr.on('data', (data) => {
  console.log(`stderr: ${data}`);
});

runner.on('close', (code) => {
  console.log(`child process exited with code ${code}`);
});