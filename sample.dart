 void main(List<String> args) {
  String i = DateTime.now().toString();
  print("Time => ${DateTime.parse("2023-04-11 17:00:00").minute}");
  print("Date => ${i.split(" ")[0]}");
}