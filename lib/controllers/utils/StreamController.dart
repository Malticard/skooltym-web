import '/exports/exports.dart';
class StreamsController with ChangeNotifier{
  List<Streams> streams = [];

  
  Future<void> getStreams(String school) async {
    // function to fetch streams
       var s = await fetchStreams(school);
       streams = s.streams;
       notifyListeners();
     
  }
}