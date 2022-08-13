import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = TextEditingController();

  final List<bool> _selection = [true, false, false];

  String tip = "0";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                tip,
                style: const TextStyle(fontSize: 30),
              ),
            ),
            const Text('Total Amount'),
            SizedBox(
              width: 70,
              child: TextField(
                controller: controller,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(hintText: '\$100.00'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ToggleButtons(
                  isSelected: _selection,
                  onPressed: updateSelection,
                  children: const [Text('10%'), Text('15%'), Text('20%')]),
            ),
            TextButton(
              onPressed: calculateTip,
              style: TextButton.styleFrom(
                primary: Colors.green,
                backgroundColor: Colors.white,
              ),
              child: const Text('Calculate Tip'),
            ),
          ],
        ),
      ),
    ));
  }

  void updateSelection(int selectedIndex) {
    setState(() {
      for (int i = 0; i < _selection.length; i++) {
        _selection[i] = selectedIndex == i;
      }
    });
  }

  void calculateTip() {
    final totalAmount = double.parse(controller.text);
    final selectedIndex = _selection.indexWhere((element) => element);
    final tipPercentage = [0.1, 0.15, 0.2][selectedIndex];

    final tipTotal = (totalAmount * tipPercentage).toStringAsFixed(2);

    setState(() {
      tip = '\$$tipTotal';
    });
  }
}
