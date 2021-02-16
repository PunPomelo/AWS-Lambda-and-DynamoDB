'use strict';
const AWS = require('aws-sdk');

AWS.config.update({ region: 'us-west-1' });

exports.handler = async (event, context, callback) => {
  const ddb = new AWS.DynamoDB({ apiVersion: '2012-10-08' });
  const documentClient = new AWS.DynamoDB.DocumentClient({
    region: 'us-west-1',
  }); // make dynamodb obj to standard json

  const { id } = event.pathParameters;

  const params = {
    TableName: 'Users',
    Key: {
      id: id, // S = String type
    },
  };

  try {
    const data = await documentClient.get(params).promise();
    const responseBody = JSON.stringify(data.Item);
    const statusCode = 200;

    return response(responseBody, statusCode);
  } catch (err) {
    const responseBody = `Unable to get user data`;
    const statusCode = 403;

    return response(responseBody, statusCode);
  }
};

const response = (responseBody, statusCode) => {
  return {
    statusCode,
    headers: {
      myHeader: 'test',
    },
    body: responseBody,
  };
};
