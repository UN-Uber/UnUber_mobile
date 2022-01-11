// Package imports:
import 'package:graphql/client.dart';

// Project imports:
import 'package:unuber_mobile/models/server_response_model.dart';
import 'package:unuber_mobile/services/api/errors/graphql_errors.dart';
import 'package:unuber_mobile/services/api/qraphql/api_client.dart';

Future <ServerResponseModel> deleteCard (String token, {required int idCard}) async {

  const String mutation = r'''
    mutation Mutation($idCard: Int!) {
      deleteCard(idCard: $idCard){
        String
      }
    }
  ''';

  Map<String, dynamic> mutationInput = {
    'idCard': idCard
  };

  MutationOptions options = MutationOptions(document: gql(mutation), variables: mutationInput);
  QueryResult result = await ApiClient().makeMutation(options, token: token, path: '');

  return handleResponse(result);
}