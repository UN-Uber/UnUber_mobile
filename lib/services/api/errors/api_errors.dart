// Project imports:
import 'package:unuber_mobile/models/server_response_model.dart';
import 'package:unuber_mobile/utils/logger.dart';

/// The function errorResponse is used to return a warning and an error response
ServerResponseModel errorResponse(dynamic excep){
  // Display a warning message to the console
  CustomLogger().logger.w(excep);

  return ServerResponseModel(
    statusCode: 500,
    hasError: true
  );
}
