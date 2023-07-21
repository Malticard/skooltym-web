import '/exports/exports.dart';
class StreamsController with ChangeNotifier{
  List<StreamModel> streams = [];

  
  Future<void> getStreams(String school) async {
    // function to fetch streams
     fetchStreams(school).asStream().listen((event) {
       streams = event;
       notifyListeners();
     });
  }
}