import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Duration _cupertinoTimerDuration = Duration();
  TimeOfDay _materialTime = TimeOfDay.now();

  void _showCupertinoTimerPicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 250,
        color: Colors.white,
        child: CupertinoTimerPicker(
          initialTimerDuration: _cupertinoTimerDuration,
          onTimerDurationChanged: (Duration newDuration) {
            setState(() {
              _cupertinoTimerDuration = newDuration;
            });
          },
        ),
      ),
    );
  }

  void _showMaterialTimePicker(BuildContext context) async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _materialTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.green,
              onPrimary: Colors.white,
              surface: Colors.green,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (newTime != null) {
      setState(() {
        _materialTime = newTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cupertino y Material Controles'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoButton(
              child: Text('Cupertino Timer Picker'),
              color: CupertinoColors.activeBlue,
              onPressed: () => _showCupertinoTimerPicker(context),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Material Time Picker'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              onPressed: () => _showMaterialTimePicker(context),
            ),
          ],
        ),
      ),
    );
  }
}
