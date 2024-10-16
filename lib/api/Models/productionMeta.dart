
import 'package:dealsify_production/api/Models/stages.dart';

import 'POModel.dart';
import 'bomItems.dart';

class ProductionMetadata {
  String? serialNo;
  String? srRange;
  String? id;
  List<ProductionStages>? productionStages;
  List<GroupBomItems>? groupBomItems;
  List<Headers>? headerArrayHeaders;
  List<Labels>? headerArrayLabels;
  List<DispatchValues>? dispatchValues;
  List<ProductionStages>? stages;

  ProductionMetadata({
    this.serialNo,
    this.srRange,
    this.id,
    this.productionStages,
    this.groupBomItems,
    this.headerArrayHeaders,
    this.headerArrayLabels,
    this.dispatchValues,
    this.stages,
  });

  factory ProductionMetadata.fromJson(Map<String, dynamic> json) {
    var stages = (json['productionStages'] as List)
        .map((stage) => ProductionStages.fromJson(stage))
        .toList();

    return ProductionMetadata(
      stages: stages,
      serialNo: json['serialNo']?.toString() ?? '',
      srRange: json['srRange']?.toString() ?? '',
      id: json['_id']?.toString() ?? '',
      productionStages: json['productionStages'] != null
          ? List<ProductionStages>.from(json['productionStages'].map((x) => ProductionStages.fromJson(x)))
          : null,
      groupBomItems: json['groupedBOMItems'] != null
          ? List<GroupBomItems>.from(json['groupedBOMItems'].map((x) => GroupBomItems.fromJson(x)))
          : null,
      headerArrayHeaders: json['headerArray']['headers'] != null
          ? List<Headers>.from(json['headerArray']['headers'].map((x) => Headers.fromJson(x)))
          : null,
      headerArrayLabels: json['headerArray']['labels'] != null
          ? List<Labels>.from(json['headerArray']['labels'].map((x) => Labels.fromJson(x)))
          : null,
      dispatchValues: json['dispatchValues'] != null
          ? List<DispatchValues>.from(json['dispatchValues'].map((x) => DispatchValues.fromJson(x)))
          : null,
    );
  }
}
