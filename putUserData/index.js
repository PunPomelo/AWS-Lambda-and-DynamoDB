'use strict';
const AWS = require('aws-sdk');

AWS.config.update({ region: 'us-west-1' });

exports.handler = async (event, context, callback) => {
  const ddb = new AWS.DynamoDB({ apiVersion: '2012-10-08' });
  const documentClient = new AWS.DynamoDB.DocumentClient({
    region: 'us-west-1',
  }); // make dynamodb obj to standard json

  const { id, firstname, lastname } = JSON.parse(event.body);

  const params = {
    TableName: 'Users',
    Item: {
      id: id, // S = String type
      firstname: firstname,
      lastname: lastname,
    },
  };

  try {
    const data = await documentClient.put(params).promise();
    const responseBody = JSON.stringify(data.Item);
    const statusCode = 201;

    return response(responseBody, statusCode);
  } catch (err) {
    const responseBody = `Unable to put user data`;
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
