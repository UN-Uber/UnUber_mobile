// Package imports:
import 'package:graphql/client.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/models/server_response_model.dart';
import 'package:unuber_mobile/services/api/errors/graphql_errors.dart';
import 'package:unuber_mobile/services/api/qraphql/api_client.dart';
import 'package:unuber_mobile/services/validations/login_validation_service.dart';

/// The function tokenGetter
Future<ServerResponseModel> tokenGetter(
    {String? email, String? telephone, required String password}) async {
  // Using the auth validation service
  final _loginValidationService = locator<LoginValidationService>();
  // Mapping the graphql query operations
  const String queryString = r'''
  query login ($authInput: AuthInput!) {
    login(authInput: $authInput) {
      token
      generatedAt
      expiresIn
    }
  }
  ''';

  // Input variables for email and password
  Map<String, dynamic> authInputEmail = {
    'authInput': {'email': email, 'password': password}
  };
  // Input variables for telephone and password
  Map<String, dynamic> authInputTelephone = {
    'authInput': {'telNumber': telephone, 'password': password}
  };

  // Transforming the graphql operations and variables into a query option
  QueryOptions options = _loginValidationService.isTelephone
      ? QueryOptions(document: gql(queryString), variables: authInputTelephone)
      : QueryOptions(document: gql(queryString), variables: authInputEmail);
  QueryResult result = await ApiClient().makeQuery(options, path: '/auth');

  return handleResponse(result);
}
