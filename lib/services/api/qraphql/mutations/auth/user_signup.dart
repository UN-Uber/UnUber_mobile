// Package imports:
import 'package:graphql/client.dart';

// Project imports:
import 'package:unuber_mobile/models/server_response_model.dart';
import 'package:unuber_mobile/services/api/errors/graphql_errors.dart';
import 'package:unuber_mobile/services/api/qraphql/api_client.dart';

Future<ServerResponseModel> userSignup(
    {required String firstName,
    String? secondName,
    required String surename,
    required int active,
    required String email,
    required String telephone,
    required String image,
    required String password}) async {
  // Mapping the graphql mutation operations
  const String mutationString = r'''
  mutation Mutation($client: ClientInput!) {
    createClient(client: $client) {
      response
    }
  }
  ''';

  // Input variables for signup
  Map<String, dynamic> clientInput = {
    'client': {
      'fName': firstName,
      'sName': secondName,
      'sureName': surename,
      'active': active,
      'email': email,
      'telNumber': telephone,
      'password': password,
      'image': image
    }
  };

  // Transforming the graphql operations and variables into a query option
  MutationOptions options =
      MutationOptions(document: gql(mutationString), variables: clientInput);
  QueryResult result = await ApiClient().makeMutation(options, path: '/auth');

  return handleResponse(result);
}
