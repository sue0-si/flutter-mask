import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewModel/store_model.dart';
import '../widget/remainStat_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final storeModel = Provider.of<StoreModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '마스크 재고 있는 곳: ${storeModel.stores.where((element) => element.remainStat != 'break').length}곳'),
        actions: [
          IconButton(
              onPressed: () {
                storeModel.fetch();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: storeModel.isLoading
          ? loadingWidget()
          : ListView(
              children: storeModel.stores
                  .where((element) => element.remainStat != 'break')
                  .map((e) {
              return RemainStatListTile(store: e);
            }).toList()),
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
