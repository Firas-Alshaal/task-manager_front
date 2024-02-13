
class Api {
  Map<String, String> setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  Future<Map<String, String>> getHeaders() async => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}
