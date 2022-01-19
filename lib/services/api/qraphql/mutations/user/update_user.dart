// Package imports:
import 'package:graphql/client.dart';

// Project imports:
import 'package:unuber_mobile/models/server_response_model.dart';
import 'package:unuber_mobile/services/api/errors/graphql_errors.dart';
import 'package:unuber_mobile/services/api/qraphql/api_client.dart';

Future<ServerResponseModel> updateUser(String token,
    {required int idClient,
    required String firstName,
    String? secondName,
    required String surename,
    required int active,
    required String email,
    required String telephone}) async {
  const String mutationString = r'''
  mutation Mutation($idClient: Int!, $client: ClientInput!) {
    updateClient(idClient: $idClient, client: $client)
  }
  ''';

  Map<String, dynamic> mutationInput = {
    'client': {
      'fName': firstName,
      'sName': secondName,
      'sureName': surename,
      'active': active,
      'email': email,
      'telNumber': telephone
    }
  };

  MutationOptions options =
      MutationOptions(document: gql(mutationString), variables: mutationInput);
  QueryResult result =
      await ApiClient().makeMutation(options, token: token, path: '');
  return handleResponse(result);
}
