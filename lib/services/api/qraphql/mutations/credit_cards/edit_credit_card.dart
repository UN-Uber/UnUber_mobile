// Package imports:
import 'package:graphql/client.dart';

// Project imports:
import 'package:unuber_mobile/models/server_response_model.dart';
import 'package:unuber_mobile/services/api/errors/graphql_errors.dart';
import 'package:unuber_mobile/services/api/qraphql/api_client.dart';

Future <ServerResponseModel> editCardInfo(String token,{
  required int idCard, required int idClient, required String cardNumber, required String dueDate, required int cvv
}) async {

  const String mutation = r'''
    mutation Mutation($idCard: Int!, $card: CreditCardInput!) {
      updateCard(idCard: $idCard, card: $card){
        String
      }
    }
  ''';

  Map<String, dynamic> mutationInput = {
    'idCard': idCard,
    'card': {
      'idClient': idClient,
      'cardNumber': cardNumber,
      'dueDate': dueDate,
      'cvv': cvv
    }
  };

  MutationOptions options = MutationOptions(document: gql(mutation), variables: mutationInput);
  QueryResult result = await ApiClient().makeMutation(options, token: token, path: '');

  return handleResponse(result);
}