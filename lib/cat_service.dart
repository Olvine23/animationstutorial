import 'package:http/http.dart' as http;
import 'dart:convert';

class CatService {
  final String _baseUrl = 'https://api.thecatapi.com/v1/images/search';
  final String _apiKey =
      'live_J9tZInxdyCKbjbGY5RG9qwcqo8TSF8PhlCwTdHP7zyAdPhXwHQCCuGNfkuZZiSAl'; // Replace with your actual API key
  final int _limit = 10;

  Future<List<Map<String, dynamic>>> getCatImages() async {
    final response = await http.get(
      Uri.parse("$_baseUrl?limit=$_limit&breed_ids=beng&api_key=$_apiKey"),
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((cat) {
        // Extract cat information
        var breedInfo = cat['breeds'].isNotEmpty ? cat['breeds'][0] : null;
        return {
          "id": cat['id'],
          "url": cat['url'],
          "breed": breedInfo != null ? breedInfo['name'] : 'Unknown',
          "description": breedInfo != null
              ? breedInfo['description']
              : 'No description available',
          "temperament": breedInfo != null
              ? breedInfo['temperament']
              : 'Unknown temperament',
          "origin": breedInfo != null ? breedInfo['origin'] : 'Unknown origin',
          "life_span": breedInfo != null ? breedInfo['life_span'] : 'Unknown',
          "wikipedia_url": breedInfo != null ? breedInfo['wikipedia_url'] : null
        };
      }).toList();
    } else {
      throw Exception("Failed to load cat images");
    }
  }
}
