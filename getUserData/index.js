'use strict';
const AWS = require('aws-sdk');

AWS.config.update({ region: 'us-east-2' });

exports.handler = function (event, context, callback) {
  const ddb = new AWS.DynamoDB({ apiVersion: '2012-10-08' });
  const documentClient = new AWS.DynamoDB.DocumentClient({
    region: 'us-east-2',
  }); // make dynamodb obj to standard json

  const params = {
    TableName: 'Users',
    Key: {
      id: '12345', // S = String type
    },
  };

  documentClient.get(params, (err, data) => {
    if (err) {
      console.log(err);
    }
    console.log(data);
  });
};
