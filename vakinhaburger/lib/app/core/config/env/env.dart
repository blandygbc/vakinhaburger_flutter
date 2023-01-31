import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'BACKEND_BASE_URL', obfuscate: true)
  static final backendBaseUrl = _Env.backendBaseUrl;
}
