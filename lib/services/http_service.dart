import 'package:http/http.dart' as http;

class HttpService {
  get(String url, {Map<String, Object> query}) async {
    var uri = Uri.parse(url);
    if (query != null) {
      uri = uri.replace(queryParameters: query);
    }
    return http.get(uri);
  }

  post(String url, Map<String, Object> data) async {
    return http.post(url, body: data);
  }
}
