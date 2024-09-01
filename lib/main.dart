import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.red,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final urlController = TextEditingController();
  double? _progress;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 100.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "FICCAMI UN BEL LINKO",
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              TextField(
                controller: urlController,
                decoration: const InputDecoration(
                    hintText: 'linko', border: OutlineInputBorder()),
              ),
              _progress != null
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        FileDownloader.downloadFile(
                            url: "http://192.168.1.34:5000/api/download?url=${urlController.text.trim()}",
                            notificationType: NotificationType.all,
                            onProgress: (name, progress) {
                              setState(() {
                                _progress = progress;
                              });
                            },
                            onDownloadCompleted: (value) {
                              setState(() {
                                _progress = null;
                              });
                            });
                      },
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(
                                horizontal: 50.0, vertical: 20.0)),
                      ),
                      child: const Text("FICCALO",
                          style: TextStyle(fontSize: 20.0)),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
