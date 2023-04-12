 void main(List<String> args) {
  String i = DateTime.now().toString();
  print("Time => ${i.split(".").first}");
  print("Date => ${i.split(" ")[0]}");
}