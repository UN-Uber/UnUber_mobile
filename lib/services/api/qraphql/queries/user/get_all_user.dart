// Package imports:
import 'package:graphql/client.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/models/server_response_model.dart';
import 'package:unuber_mobile/services/api/errors/graphql_errors.dart';
import 'package:unuber_mobile/services/api/qraphql/api_client.dart';

Future<ServerResponseModel> getUserInfo(String token, int idClient) async {
  const String query = r'''
  query Query($idClient: Int) {
  getClient(idClient: $idClient) {
    idClient
    fName
    sName
    sureName
    active
    email
    telNumber
    image
  }
}
''';

  Map<String, dynamic> queryInput = {'idClient': idClient};

  QueryOptions options =
      QueryOptions(document: gql(query), variables: queryInput);
  QueryResult result =
      await ApiClient().makeQuery(options, token: token, path: '');

  return handleResponse(result);
}
