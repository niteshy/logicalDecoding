/**
 * Created by Nitesh on 17/07/17.
 */

exports.printConfig = function (LD_SLOT, CHUNKSIZE) {
  console.log(`PGHOST = ${process.env.PGHOST}`);
  console.log(`PGUSER = ${process.env.PGUSER}`);
  console.log(`PGPASSWORD = ${process.env.PGPASSWORD}`);
  console.log(`PGDATABASE = ${process.env.PGDATABASE}`);
  console.log(`SLOT = ${LD_SLOT}`);
  console.log(`READCOUNT = ${CHUNKSIZE}`);
};

exports.printSummary = function () {


};

