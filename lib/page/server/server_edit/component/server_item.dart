import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/controller.dart';
import 'package:get/get.dart';
import 'package:kimmy/core/component/circle_chart/circle_chart.dart';
import 'package:kimmy/data/model/cpu_core_status.dart';
import 'package:kimmy/data/model/server_info.dart';
import 'package:kimmy/page/server/server_edit/server_edit_page.dart';

import '../../../../core/component/container/item_card.dart';
import '../../../../data/model/monitor_info.dart';

class ServerItem extends StatelessWidget{
  const ServerItem({
    super.key,
    required this.serverInfo,
    required this.index,
    required this.controller,
    this.onDelete, required this.monitorInfoStream});

  final int index;
  final ServerInfo serverInfo;
  final Stream<MonitorInfo>? monitorInfoStream;
  final SwipeActionController controller;
  final Function()? onDelete;

  buildCpuUsage(double cpuUsage, BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Center(
          child: Text("${cpuUsage.toStringAsFixed(1)}%"),
        )),
        CircleChart(
          progressNumber: cpuUsage,
          maxNumber: 100,
          progressColor: Theme.of(context).colorScheme.primary,
          animationDuration: const Duration(milliseconds: 500),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ItemCard(
        index: index,
        controller: controller,
        onDelete: onDelete,
        onTap: () {
          Get.to(() => ServerEditPage(serverInfo: serverInfo));
        },
        child: StreamBuilder<MonitorInfo>(
          stream: monitorInfoStream,
            builder: (context, snapshot) {
            var cpuUsage = snapshot.data == null ? 0.1 : snapshot.data!.cpuStatus.averageUsage!;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatefulBuilder(builder: (context,setState){
                    return buildCpuUsage(cpuUsage, context);
                  })
                ],
              );
            }
        )
    );
  }
}