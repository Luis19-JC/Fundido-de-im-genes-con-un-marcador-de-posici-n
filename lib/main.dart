import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final http.Response response = await http.get(
    Uri.parse(
      'https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExamVwOWh2eGZsMWgwb2I3M2J0ZHE0NTk4Y2huNmU1OGRjYTJreXN4eiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ppSjX2iP9Ec1ExJRsV/giphy.gif',
    ),
  );
  final Uint8List bytes = response.bodyBytes;
  runApp(MyApp(placeholderBytes: bytes));
}

class MyApp extends StatelessWidget {
  final Uint8List placeholderBytes;
  const MyApp({super.key, required this.placeholderBytes});

  @override
  Widget build(BuildContext context) {
    const title = 'Fade in images';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: Center(
          child: FadeInImage.memoryNetwork(
            placeholder: placeholderBytes,
            image:
                'https://i.pinimg.com/736x/d0/4d/f8/d04df81245b7d584e6c27f4f53f052bf.jpg',
          ),
        ),
      ),
    );
  }
}
