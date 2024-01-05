import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/store.dart';


class StoreRepository {

  // json에서 정보 가져오는 메소드
  Future<List<Store>> fetch(double lat, double lng) async {
    final List<Store> stores = [];

    var url =
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json';
    var response = await http.get(Uri.parse(url));
    final jsonResult = jsonDecode(response.body);
    final jsonStores = jsonResult['stores'];

    // setState(() {
       jsonStores.forEach((e) {
         stores.add(Store.fromJson(e));
       });
    //   isLoading = false;
    // });

    print('fetch 완료');
    return stores.where((element) => element.remainStat != 'break').toList();
  }
}