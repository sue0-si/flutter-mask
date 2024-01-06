import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../model/store.dart';

class StoreRepository {
  // json에서 정보 가져오는 메소드
  Future<List<Store>> fetch(double lat, double lng) async {
    final List<Store> stores = [];

    var url =
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json';

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResult = jsonDecode(response.body);
        final jsonStores = jsonResult['stores'];

        jsonStores.forEach((e) {
          final store = Store.fromJson(e);
          final meter =
              Geolocator.distanceBetween(store.lat, store.lng, lat, lng);
          store.km = double.parse((meter / 1000).toStringAsFixed(1));
          stores.add(store);
        });

        // ..
        return stores
            .where((element) => element.remainStat != 'break' && element.km < 5.0)
            .toList()..sort((a, b) => a.km.compareTo(b.km));
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
