import 'dart:convert';
import 'package:http/http.dart' as http;
import 'post_model.dart';

class HttpService {
  final String apiUrl = 'https://api.ai21.com/studio/v1/chat/completions';
  final String apiKey = 'TUkideIEcbvrCiM30rBUAw49UlD0bG32';

  Future<Post> getPost(String userMessage) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        "model": "jamba-instruct",
        "messages": [
          {"role": "user", "content": userMessage}
        ],
        "n": 1,
        "max_tokens": 4096,
        "temperature": 1,
        "top_p": 1,
        "stop": "string",
        "stream": false,
        "mock_response": {
          "response_delay_seconds": 1,
          "stream_response_delay_between_deltas_seconds": 0.1
        }
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return Post.fromJson(data);
    } else {
      throw Exception('Failed to load post: ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}
