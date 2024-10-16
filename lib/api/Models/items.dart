import 'package:dealsify_production/api/Models/POModel.dart';
import 'package:dealsify_production/api/Models/bomItems.dart';
import 'package:dealsify_production/api/Models/productionMeta.dart';
import 'package:dealsify_production/api/Models/stages.dart';

class Item {
  String? categoryId;
  List<ProductionMetadata>? productionMeta;
  List<BomItems>? bomItems;
  String? categoryName;
  String? itemId;
  String? itemName;
  String? unitId;
  String? unitName;
  String? qty;
  String? id;
  List<ProductionMetadata>? metaList;

  Item({
    this.categoryId,
    this.productionMeta,
    this.bomItems,
    this.categoryName,
    this.itemId,
    this.itemName,
    this.unitId,
    this.unitName,
    this.qty,
    this.id,
    this.metaList,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    var metaList = (json['productionMeta'] as List)
        .map((meta) => ProductionMetadata.fromJson(meta))
        .toList();

    return Item(
      metaList: metaList,
      categoryId: json['categoryId']?.toString() ?? '',
      productionMeta: json['productionMeta'] != null
          ? List<ProductionMetadata>.from(json['productionMeta'].map((x) => ProductionMetadata.fromJson(x)))
          : null,
      categoryName: json['categoryName']?.toString() ?? '',
      itemId: json['itemId']?.toString() ?? '',
      itemName: json['itemName']?.toString() ?? '',
      unitId: json['unitId']?.toString() ?? '',
      unitName: json['unitName']?.toString() ?? '',
      qty: json['qty']?.toString() ?? '',
      id: json['_id']?.toString() ?? '',
    );
  }

  List<ProductionStages> getAllProductionStages() {
    try {
      List<ProductionStages> allStages = [];
      for (var meta in metaList!) {
        allStages.addAll(meta.productionStages as Iterable<ProductionStages>);
      }
      allStages.sort((a, b) => a.priority!.compareTo(b.priority!));
      return allStages;
    } catch (e, s) {
      print(s);
      return [];
    }

  }

  ProductionStages? findFirstIncompleteStage() {
    try {
      List<ProductionStages> allStages = getAllProductionStages();
      for (var stage in allStages) {
        if (stage.isStageCompleted == false) {
          return stage;
        }
      }
      return ProductionStages();
    } catch (e, s) {
      print(s);
      return ProductionStages();
    }

  }

  List<ProductionStages> incompleteStages() {
    try {
      List<ProductionStages> allStages = getAllProductionStages();
      List<ProductionStages> inCompleteList = [];
      for (var stage in allStages) {
        if (stage.isStageCompleted == false) {
          inCompleteList.add(stage);
        }
      }
      return inCompleteList;
    } catch (e, s) {
      print(s);
      return [];
    }

  }

  List<BomItems> getAllBomItems() {
    try {
      List<BomItems> allBomItems = [];
      for (var meta in metaList!) {
        for (var groupBomItem in meta.groupBomItems ?? []) {
          allBomItems.addAll(groupBomItem.bomItems ?? []);
        }
      }
      return allBomItems;
    } catch (e, s) {
      print(s);
      return [];
    }
  }
}
