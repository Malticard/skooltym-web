import 'dart:convert';

void main(List<String> args) {
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdGFmZl9yb2xlIjoiNjRlMzE1MDhlOWE2Y2JjNWM5Y2QwMjJiIiwiX2lkIjoiNjRlMzE1YzhiMjhmMjgyYmY0Mzg1ODNjIiwiaWF0IjoxNjkyNjI3MDY1LCJleHAiOjE2OTI2MjcxMjV9.5faKBZTYfie2ndkHY1UbBlbX7QZHp0AkVyc_M9wJIvk";
  var d = json.decode(
      ascii.decode(base64.decode(base64.normalize(token.split('.')[1]))));
  final expiry = DateTime.fromMillisecondsSinceEpoch(d['exp'] * 1000);

  print("Expiry: ${expiry.toLocal()}");
  print("Current: ${DateTime.now().toLocal()}");
  print("Is expired ${DateTime.now().isAfter(expiry)}");
}
