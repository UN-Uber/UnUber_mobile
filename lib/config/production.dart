// Project imports:
import '../env.dart';

///Main class for production environment
void main() => Production();

/// The class Production is used to configure the production environment
class Production extends Env {
  // GraphQL API Gateway URL
  final String graphqlBaseURL= 'https://general-api-f6ljpbkkwa-uc.a.run.app';
}
