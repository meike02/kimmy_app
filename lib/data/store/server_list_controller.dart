import 'dart:convert';

import 'package:dartssh2/dartssh2.dart';
import 'package:get/get.dart';
import 'package:kimmy/data/model/cpu_core_status.dart';
import 'package:kimmy/data/model/sshkey_info.dart';
import 'package:kimmy/data/store/sshkey_list_controller.dart';

import '../../core/data/box_controller.dart';
import '../model/monitor_info.dart';
import '../model/server_info.dart';

class ServerListController extends BoxController<ServerInfo> {
  ServerListController() : super();
  late List<Stream<MonitorInfo>> monitorInfoStreamList;
  static const seperator = "A==========A";
  static const shellCmd = "export LANG=en_US.utf-8 \necho '$seperator' \n"
      "cat /proc/net/dev && date +%s \necho $seperator \n "
      "cat /etc/os-release | grep PRETTY_NAME \necho $seperator \n"
      "cat /proc/stat | grep cpu \necho $seperator \n"
      "uptime \necho $seperator \n"
      "cat /proc/net/snmp \necho $seperator \n"
      "df -h \necho $seperator \n"
      "cat /proc/meminfo \necho $seperator \n"
      "cat /sys/class/thermal/thermal_zone*/type \necho $seperator \n"
      "cat /sys/class/thermal/thermal_zone*/temp";
  static const shellPath = '.kimmyserver.sh';
  SSHKeyListController sshKeyController = Get.find<SSHKeyListController>();

  @override
  loadingData() async {
    await super.loadingData();
    print("modelList.length: ${modelList.length}");
    // creatStream(modelList[0]).take(150).forEach((_) {});
    monitorInfoStreamList = modelList.map((serverInfo) => creatStream(serverInfo))
        .toList();
  }

  Stream testStream() async* {
    print("\nstart stream\n");
    await Future.delayed(Duration(seconds: 5));
    var i = 0;
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield i++;
    }
  }

  Stream<MonitorInfo> creatStream(ServerInfo serverInfo) async* {
    final socket = await SSHSocket.connect(
        serverInfo.host, int.parse(serverInfo.port),
        timeout: const Duration(seconds: 30));
    final SSHClient client;
    if (serverInfo.useSSHKey) {
      while(sshKeyController.initialized){
        break;
      }
      final sshKey = SSHKeyInfo
          .fromJson(sshKeyController.get(serverInfo.sshKey!)!).privateKeyData;
      client = SSHClient(socket,
          username: serverInfo.username,
          identities: SSHKeyPair.fromPem(sshKey));
    } else {
      client = SSHClient(socket,
          username: serverInfo.username,
          onPasswordRequest: () => serverInfo.password!);
    }

    final writeResult = utf8.decode(await client
        .run("echo '$shellCmd' > $shellPath && chmod +x $shellPath"));
    if (writeResult.isNotEmpty) {
      throw Exception(writeResult);
    }
    MonitorInfo? previousMonitorInfo;

    while (true) {
      final raw = utf8.decode(await client.run("sh $shellPath"));
      final segments = raw.split(seperator).map((e) => e.trim()).toList();
      final cpuStatus = CpuStatus(segments[3], previousMonitorInfo?.cpuStatus);
      final monitorInfo = MonitorInfo(cpuStatus);
      yield monitorInfo;
      previousMonitorInfo = monitorInfo;
      print(segments[3]);
      print(cpuStatus.averageUsage);
      await Future.delayed(const Duration(seconds: 2));
    }
  }
}
