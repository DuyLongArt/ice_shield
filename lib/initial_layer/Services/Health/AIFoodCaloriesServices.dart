import 'package:http/http.dart' as http;
import 'dart:io';

class Aifoodcaloriesservices {
  final String _baseUrl = "https://backend.duylong.art/api/health/ai/calories";

  Future<String> getCalories(String foodName, {File? image}) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(_baseUrl));

      request.fields['foodName'] = foodName;

      if (image != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', image.path),
        );
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        // Assuming the response body is just the calorie count as a string
        return response.body;
      } else {
        throw Exception('Failed to get calories: ${response.statusCode}');
      }
    } catch (e) {
      print("Error in AIFoodCaloriesServices: $e");
      return "0";
    }
  }
}
