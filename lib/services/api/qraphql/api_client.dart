// Package imports:
import 'package:graphql/client.dart';

// Project imports:
import 'package:unuber_mobile/env.dart';

class ApiClient {
  static final HttpLink _endpoint = HttpLink(Env.value!.graphqlBaseURL);
  static final ApiClient _singleton = ApiClient._internal();
  factory ApiClient() => _singleton;

  ApiClient._internal() {
    _makeClient('');
  }

  GraphQLClient _makeClient(String token ) {
    AuthLink auth= AuthLink(getToken: () async => token);
    Link link= auth.concat(_endpoint);
    return GraphQLClient(cache: GraphQLCache(), link: link);
  }

  Future<QueryResult> makeQuery(QueryOptions options, {String token= ''}){
    return _makeClient(token).query(options);
  }

  Future<QueryResult> makeMutation(MutationOptions options, {String token= ''}){
    return _makeClient(token).mutate(options);
  }
}
