import 'package:flutter/material.dart';

import '../../model/store.dart';

class RemainStatListTile extends StatelessWidget {
  final Store store;

  const RemainStatListTile({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return _buildRemainStateWidget(store);
  }

  Widget _buildRemainStateWidget(Store store) {
    var remainStat = '판매종료';
    var description = '0';
    var color = Colors.black;

    switch (store.remainStat) {
      case 'plenty':
        remainStat = '충분';
        description = '> 100';
        color = Colors.green;
        break;
      case 'some':
        remainStat = '보통';
        description = '30 ~ 100개';
        color = Colors.yellow;
        break;
      case 'few':
        remainStat = '부족';
        description = '2 ~ 30개';
        color = Colors.red;
        break;
      case 'empty':
        remainStat = '소진임박';
        description = '1개 이하';
        color = Colors.grey;
        break;
      default:
    }

    return Column(
      children: <Widget>[
        Text(
          remainStat,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
        Text(
          description,
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}
