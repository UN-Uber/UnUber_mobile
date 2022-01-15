// Package imports:
import 'package:graphql/client.dart';

// Project imports:
import 'package:unuber_mobile/models/server_response_model.dart';
import 'package:unuber_mobile/services/api/errors/graphql_errors.dart';
import 'package:unuber_mobile/services/api/qraphql/api_client.dart';

Future <ServerResponseModel> listUserCreditCards(String token, {required int id}) async {
  const String query = r''' 
    query Query($idClient: Int) {
    getCardsClient(idClient: $idClient) {
      idCard
      cardNumber
      idClient
      dueDate
      cvv
    }
  }
  ''';

  Map<String, dynamic> queryInput = {
    'idClient': id
  };

  QueryOptions options = QueryOptions(document: gql(query), variables: queryInput);
  QueryResult result = await ApiClient().makeQuery(options, token: token, path: '');

  return handleResponse(result);
}
