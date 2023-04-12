 void main(List<String> args) {
  String i = DateTime.now().toString();
  print("Time => ${DateTime.parse(i.split(".").first).hour}");
  print("Date => ${i.split(" ")[0]}");
}