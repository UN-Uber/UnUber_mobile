// Package imports:
import 'package:graphql/client.dart';

// Project imports:
import 'package:unuber_mobile/env.dart';

/// ApiClient is used to generate the GraphQL client to send queries and mutations to the API Gateway
class ApiClient {
  static final HttpLink _endpoint = HttpLink(Env.value!.graphqlBaseURL);
  static final ApiClient _singleton = ApiClient._internal();
  factory ApiClient() => _singleton;

  ApiClient._internal() {
    _makeClient('');
  }

  /// The method _makeClient is used to create the client to be used in the connection
  /// @Param token is the authorization token needed to stablish the connection
  /// return a GraphQl client
  GraphQLClient _makeClient(String token) {
    AuthLink auth = AuthLink(getToken: () async => token);
    Link link = auth.concat(_endpoint);
    return GraphQLClient(cache: GraphQLCache(), link: link);
  }

  /// The method makeQuery is used to make a query to the API Gateway
  /// @Param options are the QueryOptions to be send in the GraphQl Query
  /// @Param token is the authorization token to be used in the API Gateway connection
  /// return the API Gateway Query response
  Future<QueryResult> makeQuery(QueryOptions options, {String token = ''}) {
    return _makeClient(token).query(options);
  }

  /// The method makeMutation is used to make a mutation to the API Gateway
  /// @Param options are the MutationOptions to be send in the GraphQL Mutation
  /// @Param toekn is the authorization token to be used in the API Gateway connection
  /// return the API Gateway Mutation Response
  Future<QueryResult> makeMutation(MutationOptions options,
      {String token = ''}) {
    return _makeClient(token).mutate(options);
  }
}
