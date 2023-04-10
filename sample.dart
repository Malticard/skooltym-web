 void main(List<String> args) {
  String i = DateTime.now().toString();
  print("Time => ${i.split(" ")[1]}");
  print("Date => ${i.split(" ")[0]}");
}