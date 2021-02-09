'use strict';
const AWS = require('aws-sdk');

AWS.config.update({ region: 'us-east-2' });

exports.handler = async (event, context, callback) => {
  const ddb = new AWS.DynamoDB({ apiVersion: '2012-10-08' });
  const documentClient = new AWS.DynamoDB.DocumentClient({
    region: 'us-east-2',
  }); // make dynamodb obj to standard json

  let responseBody = '';
  let statusCode = 0;

  const { id } = event.pathParameters;

  const params = {
    TableName: 'Users',
    Key: {
      id: id, // S = String type
    },
  };

  try {
    const data = await documentClient.get(params).promise();
    responseBody = JSON.stringify(data.Item);
    statusCode = 200;
  } catch (err) {
    responseBody = `Unable to get user data`;
    statusCode = 403;
  }

  const response = {
    statusCode: statusCode,
    headers: {
      myHeader: 'test',
    },
    body: responseBody,
  };

  return response;
};