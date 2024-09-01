import 'package:http/http.dart';

class HttpClientService {
  factory HttpClientService() {
    return HttpClientService.internal(Client());
  }

  HttpClientService.internal(this.client);

  final Client client;
  String? accessToken;

  static String getBearerTokenString(String accessToken) => 'Bearer $accessToken';

  static final commonHeader = {
    'content-Type': 'application/json; charset=utf-8',
  };

  void setAccessToken(String token) {
    accessToken = token;
  }

  void addAccessToken(Map<String, String> headers) {
    if (!headers.containsKey('Authorization')) {
      headers['Authorization'] = getBearerTokenString(accessToken ?? '');
    }
  }

  Future<Response> get(Uri url) async {
    final response = await client.get(url);
    return response;
  }

  Future<Response> getWithHeader(
    Uri url,
    Map<String, String> headers, {
    bool omitAccessToken = false,
  }) async {
    if (!omitAccessToken) {
      addAccessToken(headers);
    }
    final response = await client.get(url, headers: headers);
    return response;
  }
}
