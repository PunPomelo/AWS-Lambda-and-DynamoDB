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
    Item: {
      id: '67890', // S = String type
      firstname: 'Bob',
      lastname: 'Johnson',
    },
  };

  try {
    const data = await documentClient.put(params).promise();
    console.log(data);
  } catch (err) {
    console.log(err);
  }
};
