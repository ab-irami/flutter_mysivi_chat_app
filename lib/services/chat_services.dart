import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

abstract class ChatServices {
  Future<String> fetchRandomMessage();
}

class ChatServicesImpl implements ChatServices {
  String apiEndpoint = 'https://dummyjson.com/comments/';

  @override
  Future<String> fetchRandomMessage() async {
    try {
      Random random = Random();
      int randomId = random.nextInt(30) + 1;
      final uri = Uri.parse('$apiEndpoint$randomId');
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final content = json['body'] as String? ?? 'Whats up?';
        return content;
      }

      return '';
    } catch (err) {
      return '';
    }
  }
}
