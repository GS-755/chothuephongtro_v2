import 'dart:io';

class CookieParser {
  Map<String, Cookie> parseCookies(String value) {
    Map<String, Cookie> cookies = {};

    final regex = RegExp('(?:[^,]|, )+');
    Iterable<Match> rawCookies = regex.allMatches(value);
    for (var rawCookie in rawCookies) {
      try {
        if(rawCookie.group(0) != null) {
          final cookie = Cookie.fromSetCookieValue(rawCookie.group(0)!);
          cookies[cookie.name] = cookie;
        }
      } on Exception {
        // the cookie might be invalid. do something or ignore it.
        continue;
      }
    }

    return cookies;
  }
  static String getHttpCookiesAsString(Map<String, Cookie> cookies) {
    List<String> rawCookies = [];
    cookies.forEach((key, value) {
      cookies.forEach((name, cookie) {
        rawCookies.add("$name=$cookie");
      });
    });

    return rawCookies.join('; ');
  }
}
