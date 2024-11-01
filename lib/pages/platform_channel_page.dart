import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlatformChannelExample extends StatefulWidget {
  @override
  _PlatformChannelExampleState createState() => _PlatformChannelExampleState();
}

class _PlatformChannelExampleState extends State<PlatformChannelExample> {
  // Define the platform channel
  static const platform = MethodChannel('com.example.localstorage');

  String _storedValue = 'No value stored';

  // Method to store data via the platform channel
  Future<void> _storeData(String value) async {
    try {
      await platform.invokeMethod('storeData', {'value': value});
    } on PlatformException catch (e) {
      debugPrint("Failed to store data: '${e.message}'.");
    }
  }


  // Method to retrieve data from the platform channel
  Future<void> _retrieveData() async {
    try {
      final String result = await platform.invokeMethod('retrieveData');
      setState(() {
        _storedValue = result;
      });
    } on PlatformException catch (e) {
      debugPrint("Failed to retrieve data: '${e.message}'.");
    }
  }

  @override
  void initState() {
    super.initState();
    // Retrieve data when the app starts
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Platform Channel Example'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Stored Value: $_storedValue'),
              TextField(
                onSubmitted: (value) {
                  _storeData(value);
                },
                decoration: const InputDecoration(labelText: 'Enter value to store'),
              ),
              ElevatedButton(
                onPressed: _retrieveData,
                child: const Text('Retrieve Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

