// Package imports:
import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';

// Project imports:
import 'package:unuber_mobile/models/server_response_model.dart';
import 'package:unuber_mobile/services/api/errors/graphql_errors.dart';
import 'package:unuber_mobile/services/api/qraphql/api_client.dart';

Future<ServerResponseModel> deleteUser(String token, int id) async {
  const String mutationString = r''' 
  mutation UpdateClient($idClient: Int!) {
  deleteClient(idClient: $idClient)
}
  ''';

  Map<String, dynamic> mutationInput = {'idClient': id};

  MutationOptions options =
      MutationOptions(document: gql(mutationString), variables: mutationInput);
  QueryResult result =
      await ApiClient().makeMutation(options, token: token, path: '');
  return handleResponse(result);
}
