// Package imports:
import 'package:graphql/client.dart';
import 'package:unuber_mobile/app/app.locator.dart';

// Project imports:
import 'package:unuber_mobile/models/server_response_model.dart';
import 'package:unuber_mobile/services/api/errors/graphql_errors.dart';
import 'package:unuber_mobile/services/api/qraphql/api_client.dart';
import 'package:unuber_mobile/services/validations/login_validation_service.dart';

Future<ServerResponseModel> tokenGetter(
    {String? email, String? telephone, required String password}) async {
  final loginValidationService = locator<LoginValidationService>();
  const String queryString = r'''
  query login ($authInput: AuthInput!) {
    login(authInput: $authInput) {
      token
      generatedAt
      expiresIn
    }
  }
  ''';

  Map<String, dynamic> authInputEmail = {
    'authInput': {'email': email, 'password': password}
  };
  Map<String, dynamic> authInputTelephone = {
    'authInput': {'telNumber': telephone, 'password': password}
  };

  QueryOptions options = loginValidationService.isTelephone
      ? QueryOptions(document: gql(queryString), variables: authInputTelephone)
      : QueryOptions(document: gql(queryString), variables: authInputEmail);
  QueryResult result = await ApiClient().makeQuery(options, path: '/auth');

  return handleResponse(result);
}
