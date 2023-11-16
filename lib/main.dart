import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Local Auth Text Field'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _localAuth = LocalAuthentication();
  final _textController = TextEditingController();

  void _authPrompt() async {
    try {
      await _localAuth.authenticate(localizedReason: _textController.text);
    } on PlatformException {
      print('platform exception');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _textController,
              decoration: const InputDecoration(hintText: 'Username'),
              maxLength: 15,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
            ),
            const SizedBox(height: 30),
            ElevatedButton(onPressed: _authPrompt, child: const Text('Login')),
          ],
        ),
      ),
    );
  }
}
