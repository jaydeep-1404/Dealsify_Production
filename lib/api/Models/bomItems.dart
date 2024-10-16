
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
    return GroupBomItems(
      groupTitle: json['groupTitle']?.toString() ?? '',
      id: json['_id']?.toString() ?? '',
      bomItems: json['bomItems'] != null
          ? List<BomItems>.from(json['bomItems'].map((x) => BomItems.fromJson(x)))
          : null,
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
  });

  factory BomItems.fromJson(Map<String, dynamic> json) {
    return BomItems(
      categoryId: json['categoryId']?.toString() ?? '',
      categoryName: json['bomItems']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      quantity: json['quantity']?.toString() ?? '',
      materialId: json['_id']?.toString() ?? '',
      materialName: json['materialName']?.toString() ?? '',
      unitId: json['_id']?.toString() ?? '',
      unit_name: json['unit_name']?.toString() ?? '',
      hsn_code_id: json['_id']?.toString() ?? '',
      hsn_code: json['hsn_code']?.toString() ?? '',
      tax_rate_id: json['_id']?.toString() ?? '',
      tax_rate: json['tax_rate']?.toString() ?? '',
    );
  }
}
