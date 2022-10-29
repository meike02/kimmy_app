import 'package:flutter/material.dart';
import 'package:kimmy/core/component/circle_chart/circle_chart.dart';
import 'package:kimmy/data/model/server_info.dart';

class ServerItem extends StatelessWidget{
  const ServerItem({super.key, required this.serverInfo});

  final ServerInfo serverInfo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          StatefulBuilder(builder: (context,setState){
            return CircleChart(
              progressNumber: 30,
              maxNumber: 100,
              progressColor: Theme.of(context).colorScheme.primary,
              animationDuration: const Duration(milliseconds: 500),
            );
          })
        ],
      ),
    );
  }
}