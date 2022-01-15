// Package imports:
import 'package:graphql/client.dart';

// Project imports:
import 'package:unuber_mobile/models/server_response_model.dart';
import 'package:unuber_mobile/services/api/errors/graphql_errors.dart';
import 'package:unuber_mobile/services/api/qraphql/api_client.dart';

/// The function getUserById is used to query the api gateway using a graphql query
Future<ServerResponseModel> getUserById({required int id, required String token}) async {
  // Mapping the graphql query operations
  const String queryString = r'''
  query GetClient($idClient: Int) {
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

  // Input variables for user id
  Map<String, dynamic> idClient = {
    'idClient': id
  };

  // Transforming the graphql operations and variables into a query option
  QueryOptions options = QueryOptions(document: gql(queryString), variables: idClient);
  QueryResult result = await ApiClient().makeQuery(options, token: token);

  return handleResponse(result);
}
