
class GroupBomItems {
  List<BomItems>? bomItems;
  String? groupTitle;
  String? id;

  GroupBomItems({
    this.bomItems,
    this.groupTitle,
    this.id,
  });

  factory GroupBomItems.fromJson(Map<String, dynamic> json) {
    List<BomItems> bomItemsList = (json['bomItems'] as List<dynamic>)
        .map((item) => BomItems.fromJson(item, groupId: json['_id']))
        .toList();
    return GroupBomItems(
      groupTitle: json['groupTitle']?.toString() ?? '',
      id: json['_id']?.toString() ?? '',
      bomItems: bomItemsList,
    );
  }
}

class BomItems {
  String? id;
  String? categoryId;
  String? categoryName;
  String? description;
  String? quantity;
  String? materialId;
  String? materialName;
  String? unitId;
  String? unit_name;
  String? hsn_code_id;
  String? hsn_code;
  String? tax_rate_id;
  String? tax_rate;
  String? groupId;

  BomItems({
    this.id,
    this.categoryId,
    this.categoryName,
    this.description,
    this.quantity,
    this.materialId,
    this.materialName,
    this.unitId,
    this.unit_name,
    this.hsn_code_id,
    this.hsn_code,
    this.tax_rate_id,
    this.tax_rate,
    this.groupId,
  });

  factory BomItems.fromJson(Map<String, dynamic> json,{String? groupId}) {

    return BomItems(
      categoryId: json['categoryId']?.toString() ?? '',
      categoryName: json['categoryName']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      quantity: json['quantity']?.toString() ?? '',
      materialId: json['materialId']?['_id']?.toString() ?? '',
      materialName: json['materialId']?['materialName']?.toString() ?? '',
      unitId: json['unitId']?['_id']?.toString() ?? '',
      unit_name: json['unitId']?['unit_name']?.toString() ?? '',
      hsn_code_id: json['hsn_code']?['_id']?.toString() ?? '',
      hsn_code: json['hsn_code']?['hsn_code']?.toString() ?? '',
      tax_rate_id: json['tax_rate_id']?['_id']?.toString() ?? '',
      tax_rate: json['tax_rate_id']?['tax_rate']?.toString() ?? '',
      groupId: groupId,
    );
  }
}
