import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:movie_assignment/services/http_client_service.dart';

import 'http_client_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  HttpClientService httpClientService = HttpClientService();
  MockClient mockClient = MockClient();

  final testHeaders = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  setUp(() {
    httpClientService = HttpClientService.internal(mockClient);
  });

  test('Should call Client.get()', () async {
    final testUrl = Uri.https('www.google.com', 'test');
    final mockResponse = http.Response('{"message": "success"}', 200);

    when(mockClient.get(testUrl)).thenAnswer((_) async => mockResponse);
    await httpClientService.get(testUrl);

    verify(mockClient.get(testUrl));
  });

  test('Should call Client.get() when call getWithHeader', () async {
    final testUrl = Uri.https('www.google.com', 'test');
    final mockResponse = http.Response('{"message": "success"}', 200);

    when(mockClient.get(testUrl, headers: testHeaders)).thenAnswer((_) async => mockResponse);
    await httpClientService.getWithHeader(testUrl, testHeaders);

    verify(mockClient.get(testUrl, headers: testHeaders));
  });
}
