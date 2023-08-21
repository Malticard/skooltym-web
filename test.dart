import 'dart:convert';

void main(List<String> args) {
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdGFmZl9yb2xlIjoiNjRkZjg5OTUzOTAxY2VkMTY3YTYxMmFmIiwiX2lkIjoiNjRkZjkyMWZlOTJhNDljZGM1ZDUwMjA0IiwiaWF0IjoxNjkyNTk5ODc0LCJleHAiOjE2OTI2MDM0NzR9.inx6WtWFFLb57WTEVn6889Mr6NPLT8jx_ETJEQffbGs";
  var d = json.decode(
      ascii.decode(base64.decode(base64.normalize(token.split('.')[1]))));
  final expiry = DateTime.fromMillisecondsSinceEpoch(d['exp'] * 1000);

  print(DateTime.now().isAfter(expiry));
}
