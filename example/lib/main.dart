import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:bundle_resources_loader/bundle_resources_loader.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _bundleResourcesLoaderPlugin = BundleResourcesLoader();

  List<String> _results = [];

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _searchFiles() async {
    List<String> files;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      files = await _bundleResourcesLoaderPlugin.searchResources(
        fileExt: 'storekit',
        // fileName: 'Info',
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      files = [];
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _results = files;
    });
  }

  @override
  void initState() {
    super.initState();
    _searchFiles();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: ListView.builder(
          itemCount: _results.length,
          itemBuilder:
              (context, index) => ListTile(title: Text(_results[index])),
        ),
      ),
    );
  }
}
