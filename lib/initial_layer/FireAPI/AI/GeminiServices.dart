import 'package:dio/dio.dart';
import 'package:ice_shield/initial_layer/FireAPI/AI/GeminiModel.dart';
import 'package:retrofit/retrofit.dart';

part 'GeminiServices.g.dart';

@RestApi(baseUrl: "https://generativelanguage.googleapis.com/v1beta/")
abstract class GeminiService {
  factory GeminiService(Dio dio, {String baseUrl}) = _GeminiService;

  // POST request to generate content
  // We pass the apiKey as a query parameter
  @POST("models/gemini-1.5-flash:generateContent")
  Future<GeminiResponse> generateContent(
    @Query("key") String apiKey,
    @Body() GeminiRequest request,
  );
}

// import 'package:dio/dio.dart';
// import 'package:ice_shield/initial_layer/FireAPI/AI/GeminiModel.dart';
// import 'package:retrofit/retrofit.dart';

// part 'GeminiServices.g.dart';

// @RestApi(baseUrl: "https://generativelanguage.googleapis.com/v1beta/")
// abstract class GeminiService {
//   factory GeminiService(Dio dio, {String baseUrl}) = _GeminiService;

//   // POST request to generate content
//   // We pass the apiKey as a query parameter
//   @POST("models/gemini-1.5-flash:generateContent")
//   Future<GeminiResponse> generateContent(
//     @Query("key") String apiKey,
//     @Body() GeminiRequest request,
//   );
// }
