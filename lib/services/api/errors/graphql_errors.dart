// Package imports:
import 'package:graphql/client.dart';

// Project imports:
import 'package:unuber_mobile/models/server_response_model.dart';

/// The function handleResponse is used to format the server response in a more manageable way
ServerResponseModel handleResponse(QueryResult result) {
  /// Is the respose model to store the response in a proper way
  ServerResponseModel response = ServerResponseModel();

  if (result.exception != null) {
    if (result.exception!.linkException != null) {
      response.hasError = true;
      response.statusCode = 500;
    }
    // Add other exceptions here
  }

  if (result.data == null) {
    // Add all errors variables to the response
    response.hasError = true;
    response.statusCode = getStatusCode(
        result.exception!.graphqlErrors[0].extensions!['code'] as String);
    response.exception = result.exception;
  } else {
    // Add all data variables to the response
    response.statusCode = 201;
    response.data = result.data;
  }

  return response;
}

/// The function getStatusCode converts the exception extension into the status code
/// - @Param error is the exception extension to convert
/// - return the corresponding status code
int getStatusCode(String error) {
  switch (error) {
    case 'UNAUTHENTICATED':
      return 401;
    default:
      return 400;
  }
}
