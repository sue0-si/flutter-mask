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
      body: _buildBody(storeModel)
    );
  }

  Widget _buildBody(StoreModel storeModel) {
    if (storeModel.isLoading == true) {
      return loadingWidget();
    }

    if (storeModel.stores.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('반경 5km 이내에 재고가 있는 매장이 없습니다.'),
            Text('또는 인터넷에 연결되어 있는지 확인해주세요.'),
          ],
        ),
      );
    }

    return ListView(
        children: storeModel.stores
            .where((element) => element.remainStat != 'break')
            .map((e) {
          return RemainStatListTile(store: e);
        }).toList());
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
