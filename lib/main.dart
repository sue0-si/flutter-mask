import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mask/model/store.dart';
import 'package:http/http.dart' as http;

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Store> stores = [];
  var isLoading = true;

  // json에서 정보 가져오는 메소드
  Future fetch() async {
    setState(() {
      isLoading = true;
    });

    var url =
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json';
    var response = await http.get(Uri.parse(url));
    final jsonResult = jsonDecode(response.body);
    final jsonStores = jsonResult['stores'];

    setState(() {
      stores.clear();
      jsonStores.forEach((e) {
        stores.add(Store.fromJson(e));
      });
      isLoading = false;
    });
  }

  @override
  void initState() {
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마스크 재고 있는 곳: ${stores.length}곳'),
        actions: [
          IconButton(onPressed: fetch, icon: const Icon(Icons.refresh))
        ],
      ),
      body: isLoading ? loadingWidget()
      : ListView.builder(
        itemCount: stores.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(stores[index].name ?? ''),
            subtitle: Text(stores[index].addr ?? ''),
          );
        },
      ),
    );
  }

  Widget loadingWidget() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('정보를 가져오는 중'),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
