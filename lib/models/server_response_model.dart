/// ServerResponseModel is used to manage the API Gateway responses
class ServerResponseModel {
  /// Is a flag to detect if the server response has an error
  bool hasError;

  /// Is the error message to display when the server respose has an error
  String? errorMessage;

  /// Is the status code of the server response
  int? statusCode;

  /// Is the response data given by the server
  dynamic data;

  /// Is the exception value given by the server when an error occurs
  dynamic exception;

  ServerResponseModel(
      {this.hasError = false,
      this.errorMessage,
      this.statusCode,
      this.data,
      this.exception});
}
