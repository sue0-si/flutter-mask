import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter_mask/repository/store_repository.dart';
import 'package:geolocator/geolocator.dart';

import '../model/store.dart';
import '../repository/location_repository.dart';

class StoreModel with ChangeNotifier {
  var isLoading = false;
  List<Store> stores = [];

  final _storeRepository = StoreRepository();
  final _locationRepository = LocationRepository();

  StoreModel() {
    fetch();
  }

  Future fetch() async {
    isLoading = true;
    notifyListeners();


    isLoading = false;
    notifyListeners();
  }
}