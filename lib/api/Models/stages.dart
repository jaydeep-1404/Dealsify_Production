
class ActiveStage {
  String stageId;
  String label;
  int priority;
  String inspector;
  bool isStageCompleted;
  List<ProductionChildStage> productionChildStages;
  List<String> mandatoryStages;
  String id;

  ActiveStage({
    required this.stageId,
    required this.label,
    required this.priority,
    required this.inspector,
    required this.isStageCompleted,
    required this.productionChildStages,
    required this.mandatoryStages,
    required this.id,
  });

  factory ActiveStage.fromJson(Map<String, dynamic> json) {
    var stages = json['productionChildStages'] as List;
    List<ProductionChildStage> childStagesList =
    stages.map((stage) => ProductionChildStage.fromJson(stage)).toList();

    return ActiveStage(
      stageId: json['stageId'] ?? '',
      label: json['label'] ?? '',
      priority: json['priority'] ?? 0,
      inspector: json['inspector'] ?? '',
      isStageCompleted: json['isStageCompleted'] ?? false,
      productionChildStages: childStagesList,
      mandatoryStages: List<String>.from(json['mandatoryStages'] ?? []),
      id: json['_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stageId': stageId,
      'label': label,
      'priority': priority,
      'inspector': inspector,
      'isStageCompleted': isStageCompleted,
      'productionChildStages': productionChildStages.map((stage) => stage.toJson()).toList(),
      'mandatoryStages': mandatoryStages,
      '_id': id,
    };
  }
}


class ProductionChildStage {
  String label;
  String labelSlug;
  String worker;
  bool isRequired;
  int priority;
  int approxProcessTimeInHours;
  String id;

  ProductionChildStage({
    required this.label,
    required this.labelSlug,
    required this.worker,
    required this.isRequired,
    required this.priority,
    required this.approxProcessTimeInHours,
    required this.id,
  });

  factory ProductionChildStage.fromJson(Map<String, dynamic> json) {
    return ProductionChildStage(
      label: json['label'] ?? '',
      labelSlug: json['labelSlug'] ?? '',
      worker: json['worker'] ?? '',
      isRequired: json['isRequired'] ?? false,
      priority: json['priority'] ?? 0,
      approxProcessTimeInHours: json['approxProcessTimeInHours'] ?? 0,
      id: json['_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'labelSlug': labelSlug,
      'worker': worker,
      'isRequired': isRequired,
      'priority': priority,
      'approxProcessTimeInHours': approxProcessTimeInHours,
      '_id': id,
    };
  }
}


class ProductionStages {
  String? id;
  String? stageId;
  String? label;
  num? priority;
  List<dynamic>? inspector;
  String? startingDate;
  String? endingDate;
  String? startingTime;
  String? endingTime;
  bool? isStageCompleted;
  List<ProductionChildStages>? productionChildStages;
  List<dynamic>? mandatoryStages;

  ProductionStages({
    this.id,
    this.stageId,
    this.label,
    this.priority,
    this.inspector,
    this.isStageCompleted,
    this.productionChildStages,
    this.mandatoryStages,
    this.startingDate,
    this.endingDate,
    this.startingTime,
    this.endingTime,
  });

  factory ProductionStages.fromJson(Map<String, dynamic> json) {
    return ProductionStages(
      id: json['_id']?.toString() ?? '',
      stageId: json['stageId']?.toString() ?? '',
      label: json['label']?.toString() ?? '',
      priority: json['priority'] ?? 0,
      // inspector: json['inspector']?.toString() ?? '',
      inspector: (json['inspector'] is List)
          ? List<String>.from(json['inspector'].map((item) => item.toString()))
          : (json['inspector'] is String)
          ? [json['inspector'].toString()]
          : [],
      startingDate: json['startingDate']?.toString() ?? '',
      endingDate: json['endingDate']?.toString() ?? '',
      startingTime: json['startingTime']?.toString() ?? '',
      endingTime: json['endingTime']?.toString() ?? '',
      isStageCompleted: json['isStageCompleted'] ?? false,
      productionChildStages: json['productionChildStages'] != null
          ? List<ProductionChildStages>.from(json['productionChildStages'].map((x) => ProductionChildStages.fromJson(x)))
          : null,
      mandatoryStages: json['mandatoryStages'] ?? [],

    );
  }
}

class ProductionChildStages {
  String? id;
  String? label;
  String? labelSlug;
  String? isRequired;
  String? priority;
  String? approxProcessTimeInHours;

  ProductionChildStages({
    this.id,
    this.label,
    this.labelSlug,
    this.isRequired,
    this.priority,
    this.approxProcessTimeInHours,
  });

  factory ProductionChildStages.fromJson(Map<String, dynamic> json) {
    return ProductionChildStages(
      id: json['_id']?.toString() ?? '',
      label: json['label']?.toString() ?? '',
      labelSlug: json['labelSlug']?.toString() ?? '',
      isRequired: json['isRequired']?.toString() ?? '',
      priority: json['priority']?.toString() ?? '',
      approxProcessTimeInHours: json['approxProcessTimeInHours']?.toString() ?? '',

    );
  }
}
