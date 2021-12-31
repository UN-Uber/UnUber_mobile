// Project imports:
import '../env.dart';

/// Main class for development environment
void main() => Development();


/// The class Development is used to configure the development environment
class Development extends Env {
  // GraphQL API Gateway URL
  final String graphqlBaseURL= 'https://general-api-f6ljpbkkwa-uc.a.run.app';
}
