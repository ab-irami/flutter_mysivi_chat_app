import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class TranslatorServices {
  Future<String> translateText(String text);
}

class TranslatorServicesImpl implements TranslatorServices {
  String apiEndpoint =
      'https://ftapi.pythonanywhere.com/translate?sl=en&dl=fr&text=';

  @override
  Future<String> translateText(String text) async {
    try {
      final uri = Uri.parse('$apiEndpoint$text');
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        print("Translation response: $json");
        final content = json['destination-text'] as String? ?? 'Whats up?';
        return content;
      }

      return text;
    } catch (err) {
      print("Error during translation: $err");
      return text;
    }
  }
}
