import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/store.dart';

class RemainStatListTile extends StatelessWidget {
  final Store store;

  const RemainStatListTile({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(store.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(store.addr),
          Text('${store.km}'),
        ],
      ),
      trailing: _buildRemainStateWidget(store),
      onTap: () {
        _launchUrl(store.lat, store.lng);
      },
    );
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

Future<void> _launchUrl(double lat, double lng) async {
  final Uri _url = Uri.parse('https://google.com/maps/search/?api=1&query=$lat,$lng');
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
