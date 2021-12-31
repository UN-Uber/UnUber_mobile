// Project imports:
import '../env.dart';

/// Main class for staging environment
void main() => Staging();

/// The class Staging is used to configure the staging environment
class Staging extends Env {
  // GraphQL API Gateway URL
  final String graphqlBaseURL= 'https://general-api-f6ljpbkkwa-uc.a.run.app';
}
