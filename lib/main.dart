import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SSL Certificate Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _response = 'Response will be displayed here';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SSL Certificate Example'),
      ),
      body: Center(
        child: ListView(
          children: [
            ElevatedButton(
              onPressed: () async {
                // Replace 'your_api_endpoint' with the actual API endpoint
                const String apiUrl =
                    'https://jsonplaceholder.typicode.com/posts';

                try {
                  // Load and apply SSL certificate
                  ByteData data =
                      await rootBundle.load('assets/certificate.crt');
                  SecurityContext securityContext =
                      SecurityContext.defaultContext;
                  securityContext
                      .setTrustedCertificatesBytes(data.buffer.asUint8List());
                  print(securityContext.toString());

                  // Make a secure request
                  // http.Response response = await http.get(Uri.parse(apiUrl), context: securityContext);
                  http.Response response = await http.get(Uri.parse(apiUrl),
                      headers: {'content-type': 'application/json'});

                  // Display the response
                  setState(() {
                    _response = 'Response: ${response.body}';
                  });
                } catch (e) {
                  setState(() {
                    _response = 'Error: $e';
                  });
                }
              },
              child: const Text('Make Secure Request'),
            ),
            const SizedBox(height: 20),
            Text(_response),
          ],
        ),
      ),
    );
  }
}
