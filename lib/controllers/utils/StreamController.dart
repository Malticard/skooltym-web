import '/exports/exports.dart';
class StreamsController with ChangeNotifier{
  List<StreamModel> _streams = [];

  List<StreamModel> get streams => _streams;
  
  Future<void> getStreams(String school) async {
    // function to fetch streams
     fetchStreams(school).asStream().listen((event) {
       _streams = event;
       notifyListeners();
     });
  }
}