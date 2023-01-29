class CpuCoreStatus {
  CpuCoreStatus(String rawCoreStatusText) {
    coreName = rawCoreStatusText.split(" ").first;
    List<String> rawCoreStatus = rawCoreStatusText
        .replaceAll(coreName, " ")
        .trim()
        .split(" ");
    user = int.parse(rawCoreStatus[0]);
    nice = int.parse(rawCoreStatus[1]);
    system = int.parse(rawCoreStatus[2]);
    idle = int.parse(rawCoreStatus[3]);
    iowait = int.parse(rawCoreStatus[4]);
    irq = int.parse(rawCoreStatus[5]);
    softirq = int.parse(rawCoreStatus[6]);
  }
  late String coreName;

  late int user;

  late int nice;

  late int system;

  late int idle;

  late int iowait;

  late int irq;

  late int softirq;

  int get sum {
    return user + nice + system + idle + iowait + irq + softirq;
  }
}


class CpuStatus{
  CpuStatus(String rawStatusText, CpuStatus? previousCpuStatus) {
    previousTotalStatus = previousCpuStatus?.totalStatus;
    previousCoreStatus = previousCpuStatus?.coreStatus;
    coreStatus = [];
    
    List<String> rawCoreStatusTextList = rawStatusText.split("\n");
    for(int i = 0; i < rawCoreStatusTextList.length; i++) {
      if(i == 0) {
        totalStatus = CpuCoreStatus(rawCoreStatusTextList[i]);
      }
      coreStatus.add(CpuCoreStatus(rawCoreStatusTextList[0]));
    }
  
  }

  CpuCoreStatus? previousTotalStatus;

  List<CpuCoreStatus>? previousCoreStatus;
  
  late CpuCoreStatus totalStatus;

  late List<CpuCoreStatus> coreStatus;



  List<double>? get coreUsages{
    if(previousCoreStatus == null) {
      return null;
    }
    List<double> coreUsageList = [];
    for (int i = 0; i < previousCoreStatus!.length; i++) {
      coreUsageList.add(_computeCoreUsage(previousCoreStatus![i], coreStatus[i]));
    }
    return coreUsageList;
  }

  double? get averageUsage {
    if(previousTotalStatus == null) {
      return 0.1;
    }
    return _computeCoreUsage(previousTotalStatus!, totalStatus);
  }
}

double _computeCoreUsage(CpuCoreStatus previousCoreStatus,
    CpuCoreStatus currentCoreStatus){
  var coreUsage = 100 - 100 * (currentCoreStatus.idle - previousCoreStatus.idle) /
      (currentCoreStatus.sum - previousCoreStatus.sum);
  coreUsage = coreUsage == 0.0 ? 0.1 : coreUsage;
  return coreUsage;
}