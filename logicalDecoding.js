/**
 * Created by Nitesh on 17/07/17.
 */
const _     = require('lodash');
const util = require('util');
const async = require('async');
const { Pool, Client } = require('pg');
const debug = require('debug')('decoding');

const utils = require('./utils/common.js');

var self = this;
var LD_SLOT;
var total = 0;

LD_SLOT             = process.env.LD_SLOT ? process.env.LD_SLOT : 'reader_slot';
process.env.PGHOST  = process.env.PGHOST ? process.env.PGHOST : '127.0.0.1';
process.env.PGUSER  = process.env.PGUSER ? process.env.PGUSER : 'postgres';
process.env.PGPASSWORD = process.env.PGPASSWORD ? process.env.PGPASSWORD : '';
process.env.PGDATABASE = process.env.PGDATABASE ? process.env.PGDATABASE : 'testdb1';

const CHUNKSIZE = 1000;
/*
 * readRow: To read set of replication records from given client, LD_SLOT
 *          and till the next row
 */
var readRow = function (client, slot, next) {
  return function (cb) {
    debug('decoding: ', next);
    client.query(`SELECT * FROM pg_logical_slot_peek_changes('${slot}', '${next.location}', ${next.xid}, 'include-timestamp', 'on')`, (err, res) => {
      if (err) {
        debug('decoding:readRow: error', err);
        console.error('decoding:readRow: error', err);
        return cb(err);
      }
      if (res && res.rows) {
        _.forEach(res.rows, function (r) {
          //debug(r.location, r.xid, r.data)
          console.log(r.location, r.xid, r.data)
        })
      }
      return cb(null, res.rows);
    });
  }
};

utils.printConfig(LD_SLOT, CHUNKSIZE);

const client = new Client();
client.connect();

client.query(`SELECT location, xid FROM pg_logical_slot_peek_changes('${LD_SLOT}', NULL, NULL, 'include-timestamp', 'on')`, (err, res) => {
  if (err) {
    debug('decoding:query: error', err);
    console.error('decoding:query: error', err);
    return err;
  }
  if (res.rows) {
    _.forEach(res.rows, function (r) {
      // console.log(r.location, r.xid, r.data)
    })
  }
  total = res.rows.length;

  var chunks = _.chunk(res.rows, CHUNKSIZE);
  var tasks = [];
  _.forEach(chunks, function (rows, idx) {
    var next = _.last(rows);
    debug(`${idx} rows -> `, next);
    tasks.push(readRow(client, LD_SLOT, next))
  });

  //debug(util.inspect(tasks, { showHidden: false, depth: null }))
  async.series(tasks, function (err, results) {
    if (err) {
      console.error('decoding:query: err ', err);
      return;
    } else {
      //debug(results);
    }
    console.log('Total records consumed = ', total);
    client.end()
  });
});
