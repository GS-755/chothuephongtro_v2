import 'package:flutter_dotenv/flutter_dotenv.dart';

class UriBuilder {
  static Uri buildApiUri(String expectedDestination) {
    return Uri.parse('${dotenv.env['API_URL']}${expectedDestination.trim()}');
  }
  static String buildImageUrl(String expectedDestination) {
    return '${dotenv.env['IMG_URL']}${expectedDestination.trim()}';
  }
}
