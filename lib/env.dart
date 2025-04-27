import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'NEWS_API_KEY', obfuscate: true)
  static final String newsApiKey = _Env.newsApiKey;
}