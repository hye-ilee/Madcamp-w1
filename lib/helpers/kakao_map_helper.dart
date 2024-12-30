import 'package:url_launcher/url_launcher.dart';

class KakaoMapHelper {
  /// Opens Kakao Place using the given Kakao Place ID.
  static Future<void> openKakaoPlaceWithId(String kakaoId) async {
    // Construct the Kakao Place URL
    final kakaoMapUri = Uri.parse('https://place.map.kakao.com/$kakaoId');

    launchUrl(kakaoMapUri);
  }
}
