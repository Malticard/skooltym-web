import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class Guardian {
  final String name;
  final int age;

  Guardian({required this.name, required this.age});

  factory Guardian.fromJson(Map<String, dynamic> json) {
    return Guardian(
      name: json['name'],
      age: json['age'],
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String apiUrl =
      'http://13.127.169.59:5050/get/guardians/64c0c4a9d4c2f22e94a3a271';
  StreamController<Guardian> _guardianStreamController =
      StreamController<Guardian>();
  Timer? _timer;
  late StreamSubscription<Guardian> _subscription ;

  @override
  void initState() {
    super.initState();
    _subscription.onData((data) {
      _guardianStreamController.add(data);
    },);
    _fetchGuardians();
  }

  @override
  void dispose() {
    _guardianStreamController.close();
    _timer?.cancel();
    _subscription.cancel();
    super.dispose();
  }

  void _fetchGuardians() async {
    try {
      // Fetch the initial data from the server
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final guardian = Guardian.fromJson(jsonData);
        _guardianStreamController.add(guardian);

        // Setup a timer to fetch updates periodically
        _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
          final response = await http.get(Uri.parse(apiUrl));
          if (response.statusCode == 200) {
            final jsonData = json.decode(response.body);
            final guardian = Guardian.fromJson(jsonData);
            _guardianStreamController.add(guardian);
          }
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Real-time Data from Server with StreamBuilder'),
      ),
      body: Center(
        child: StreamBuilder<Guardian>(
          stream: _guardianStreamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Guardian Name: ${snapshot.data!.name}',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    'Guardian Age: ${snapshot.data!.age}',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
