import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'API_KEY')
  static const String apiKey = _Env.apiKey;

  @EnviedField(varName: 'ACCESS_TOKEN')
  static const String accessToken = _Env.accessToken;

  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _Env.baseUrl;

  @EnviedField(varName: 'IMAGE_BASE_URL')
  static const String imageBaseUrl = _Env.imageBaseUrl;
}
