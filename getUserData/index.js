'use strict';
const AWS = require('aws-sdk');

AWS.config.update({ region: 'us-east-2' });

exports.handler = function (event, context, callback) {
  const ddb = new AWS.DynamoDB({ apiVersion: '2012-10-08' });

  const params = {
    TableName: 'Users',
    Key: {
      id: {
        S: '12345', // S = String type
      },
    },
  };

  ddb.getItem(params, (err, data) => {
    if (err) {
      console.log(err);
    }
    console.log(data);
  });
};
