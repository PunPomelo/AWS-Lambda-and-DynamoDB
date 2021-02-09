'use strict';
const AWS = require('aws-sdk');

AWS.config.update({ region: 'us-east-2' });

exports.handler = async (event, context, callback) => {
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

  try {
    const data = await documentClient.get(params).promise();
    console.log(data);
  } catch (err) {
    console.log(err);
  }
};
