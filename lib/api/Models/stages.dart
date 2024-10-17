class ProductionStages {
  String? id;
  String? stageId;
  String? label;
  num? priority;
  String? inspector;
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
      inspector: json['inspector']?.toString() ?? '',
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
