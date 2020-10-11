import 'package:http/http.dart' as http;

class HttpService {
  get(String url) async {
    return http.get(url);
  }

  post(String url, Map<String, Object> data) async {
    return http.post(url, body: data);
  }
}
