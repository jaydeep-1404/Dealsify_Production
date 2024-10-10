import 'dart:convert';

class ProductionOrder {
  String? id;
  DateTime? orderDate;
  DateTime? dispatchDate;
  DateTime? expectedDate;
  bool? isAutoGenSeq;
  String? notes;
  bool? confirmBOMCompletion;
  int? productionPriorityLevel;
  String? companyId;
  String? createdId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? productionOrderNo;
  int? v;
  Customer? customerId;
  ProductionOrderStatus? productionOrderStatus;
  List<Item>? items;

  ProductionOrder({
    this.id,
    this.orderDate,
    this.dispatchDate,
    this.expectedDate,
    this.isAutoGenSeq,
    this.notes,
    this.confirmBOMCompletion,
    this.productionPriorityLevel,
    this.companyId,
    this.createdId,
    this.createdAt,
    this.updatedAt,
    this.productionOrderNo,
    this.v,
    this.customerId,
    this.productionOrderStatus,
    this.items,
  });

  factory ProductionOrder.fromJson(Map<String, dynamic> json) {
    return ProductionOrder(
      id: json['_id'],
      orderDate: json['orderDate'] != null ? DateTime.parse(json['orderDate']) : null,
      dispatchDate: json['dispatchDate'] != null ? DateTime.parse(json['dispatchDate']) : null,
      expectedDate: json['expectedDate'] != null ? DateTime.parse(json['expectedDate']) : null,
      isAutoGenSeq: json['isAutoGenSeq'] ?? false,
      notes: json['notes'],
      confirmBOMCompletion: json['confirmBOMCompletion'] ?? false,
      productionPriorityLevel: json['productionPriorityLevel'],
      companyId: json['companyId'],
      createdId: json['createdId'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      productionOrderNo: json['productionOrderNo'],
      v: json['__v'],
      customerId: json['customerId'] != null ? Customer.fromJson(json['customerId']) : null,
      productionOrderStatus: json['productionOrderStatus'] != null
          ? ProductionOrderStatus.fromJson(json['productionOrderStatus'])
          : null,
      items: json['items'] != null
          ? List<Item>.from(json['items'].map((x) => Item.fromJson(x)))
          : null,
    );
  }
}

class Customer {
  String? id;
  String? customerType;
  PaymentTerms? paymentTermsId;
  String? customerName;
  String? shortName;
  String? contactPerson;
  List<PhoneNumber>? phoneNumber;
  String? openingBalance;
  String? gstIn;
  String? website;
  String? email;
  String? notes;
  String? openBalanceType;
  String? sameAsBiling;
  Address? billingAddress;
  Address? shippingAddress;
  String? companyId;
  String? userId;
  String? createdId;
  String? updatedId;
  String? createdAt;
  String? updatedAt;
  String? v;
  List<CustomCustomerField>? customCustomersFields;

  Customer({
    this.id,
    this.customerType,
    this.paymentTermsId,
    this.customerName,
    this.shortName,
    this.contactPerson,
    this.phoneNumber,
    this.openingBalance,
    this.gstIn,
    this.website,
    this.email,
    this.notes,
    this.openBalanceType,
    this.sameAsBiling,
    this.billingAddress,
    this.shippingAddress,
    this.companyId,
    this.userId,
    this.createdId,
    this.updatedId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.customCustomersFields,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['_id']?.toString() ?? '',
      customerType: json['customer_type']?.toString() ?? '',
      paymentTermsId: json['payment_terms_id'] != null
          ? PaymentTerms.fromJson(json['payment_terms_id'])
          : null,
      customerName: json['customer_name']?.toString() ?? '',
      shortName: json['shortName']?.toString() ?? '',
      contactPerson: json['contact_person']?.toString() ?? '',
      phoneNumber: json['phoneNumber'] != null
          ? List<PhoneNumber>.from(json['phoneNumber'].map((x) => PhoneNumber.fromJson(x)))
          : null,
      openingBalance: json['opening_balance']?.toString() ?? '',
      gstIn: json['gst_in']?.toString() ?? '',
      website: json['website']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      notes: json['notes']?.toString() ?? '',
      openBalanceType: json['open_balance_type']?.toString() ?? '',
      sameAsBiling: json['same_as_biling']?.toString() ?? '',
      billingAddress: json['billingAddress'] != null
          ? Address.fromJson(json['billingAddress'])
          : null,
      shippingAddress: json['shippingAddress'] != null
          ? Address.fromJson(json['shippingAddress'])
          : null,
      companyId: json['company_id']?.toString() ?? '',
      userId: json['user_id']?.toString() ?? '',
      createdId: json['created_id']?.toString() ?? '',
      updatedId: json['updated_id']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      v: json['__v']?.toString() ?? '',
      customCustomersFields: json['customCustomersFields'] != null
          ? List<CustomCustomerField>.from(
          json['customCustomersFields'].map((x) => CustomCustomerField.fromJson(x)))
          : null,
    );
  }
}

class PaymentTerms {
  String? id;
  String? paymentTermsName;

  PaymentTerms({
    this.id,
    this.paymentTermsName,
  });

  factory PaymentTerms.fromJson(Map<String, dynamic> json) {
    return PaymentTerms(
      id: json['_id']?.toString() ?? '',
      paymentTermsName: json['payment_terms_name']?.toString() ?? '',
    );
  }
}

class PhoneNumber {
  String? phone;

  PhoneNumber({
    this.phone,
  });

  factory PhoneNumber.fromJson(Map<String, dynamic> json) {
    return PhoneNumber(
      phone: json['phone']?.toString() ?? '',
    );
  }
}

class Address {
  Country? country;
  State? state;
  String? city;
  String? pincode;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;

  Address({
    this.country,
    this.state,
    this.city,
    this.pincode,
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      country: json['country'] != null ? Country.fromJson(json['country']) : null,
      state: json['state'] != null ? State.fromJson(json['state']) : null,
      city: json['city']?.toString() ?? '',
      pincode: json['pincode']?.toString() ?? '',
      addressLine1: json['addressLine1']?.toString() ?? '',
      addressLine2: json['addressLine2']?.toString() ?? '',
      addressLine3: json['addressLine3']?.toString() ?? '',
    );
  }
}

class Country {
  String? id;
  String? name;

  Country({
    this.id,
    this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }
}

class State {
  String? id;
  String? name;

  State({
    this.id,
    this.name,
  });

  factory State.fromJson(Map<String, dynamic> json) {
    return State(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }
}

class CustomCustomerField {
  String? isActive;
  String? defaultValue;
  String? isRequired;
  String? label;
  String? labelSlug;
  String? modelType;

  CustomCustomerField({
    this.isActive,
    this.defaultValue,
    this.isRequired,
    this.label,
    this.labelSlug,
    this.modelType,
  });

  factory CustomCustomerField.fromJson(Map<String, dynamic> json) {
    return CustomCustomerField(
      isActive: json['isActive']?.toString() ?? '',
      defaultValue: json['defaultValue']?.toString() ?? '',
      isRequired: json['isRequired']?.toString() ?? '',
      label: json['label']?.toString() ?? '',
      labelSlug: json['labelSlug']?.toString() ?? '',
      modelType: json['modelType']?.toString() ?? '',
    );
  }
}

class ProductionOrderStatus {
  String? id;
  String? companyId;
  String? statusLabel;
  String? statusColor;
  String? isActive;
  String? priority;
  String? userId;
  String? createdId;
  String? createdAt;
  String? updatedAt;
  String? v;

  ProductionOrderStatus({
    this.id,
    this.companyId,
    this.statusLabel,
    this.statusColor,
    this.isActive,
    this.priority,
    this.userId,
    this.createdId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ProductionOrderStatus.fromJson(Map<String, dynamic> json) {
    return ProductionOrderStatus(
      id: json['_id']?.toString() ?? '',
      companyId: json['companyId']?.toString() ?? '',
      statusLabel: json['statusLabel']?.toString() ?? '',
      statusColor: json['statusColor']?.toString() ?? '',
      isActive: json['isActive']?.toString() ?? '',
      priority: json['priority']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      createdId: json['createdId']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      v: json['__v']?.toString() ?? '',
    );
  }
}

class Item {
  String? id;
  Product? productId;
  String? orderQuantity;
  String? producedQuantity;
  String? createdId;
  String? createdAt;
  String? updatedAt;
  String? v;

  Item({
    this.id,
    this.productId,
    this.orderQuantity,
    this.producedQuantity,
    this.createdId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['_id']?.toString() ?? '',
      productId: json['product_id'] != null ? Product.fromJson(json['product_id']) : null,
      orderQuantity: json['orderQuantity']?.toString() ?? '',
      producedQuantity: json['producedQuantity']?.toString() ?? '',
      createdId: json['created_id']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      v: json['__v']?.toString() ?? '',
    );
  }
}

class Product {
  String? id;
  String? productName;
  String? productNo;
  String? companyId;
  String? productCategoryId;
  String? itemType;
  String? unit;
  String? isProductSaleable;
  String? isProductPurchasable;
  String? isProductManufacturable;
  String? isActive;
  String? createdId;
  String? createdAt;
  String? updatedAt;
  String? v;

  Product({
    this.id,
    this.productName,
    this.productNo,
    this.companyId,
    this.productCategoryId,
    this.itemType,
    this.unit,
    this.isProductSaleable,
    this.isProductPurchasable,
    this.isProductManufacturable,
    this.isActive,
    this.createdId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id']?.toString() ?? '',
      productName: json['product_name']?.toString() ?? '',
      productNo: json['product_no']?.toString() ?? '',
      companyId: json['company_id']?.toString() ?? '',
      productCategoryId: json['product_category_id']?.toString() ?? '',
      itemType: json['item_type']?.toString() ?? '',
      unit: json['unit']?.toString() ?? '',
      isProductSaleable: json['is_product_saleable']?.toString() ?? '',
      isProductPurchasable: json['is_product_purchasable']?.toString() ?? '',
      isProductManufacturable: json['is_product_manufacturable']?.toString() ?? '',
      isActive: json['isActive']?.toString() ?? '',
      createdId: json['created_id']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      v: json['__v']?.toString() ?? '',
    );
  }
}


Map <String , dynamic> data = {
  "data": [
    {
      "_id": "67075d19720ddf065bb9f37f",
      "orderDate": "2024-10-10T00:00:00.000Z",
      "dispatchDate": "2024-10-10T00:00:00.000Z",
      "expectedDate": "2024-10-10T00:00:00.000Z",
      "isAutoGenSeq": false,
      "notes": "",
      "confirmBOMCompletion": false,
      "productionPriorityLevel": 100,
      "companyId": "64f02d9ae92067d72a522c6e",
      "createdId": "6585723e966c57e76be60372",
      "createdAt": "2024-10-10T04:50:33.372Z",
      "updatedAt": "2024-10-10T04:52:38.893Z",
      "productionOrderNo": 65,
      "__v": 0,
      "customerId": {
        "_id": "66e90b30a2a2c0e20ab07b51",
        "customer_type": "both",
        "payment_terms_id": {
          "_id": "668bbb331716bf7d96c72fce",
          "payment_terms_name": "5 Days"
        },
        "customer_name": "Dealsify 1",
        "shortName": "DL",
        "contact_person": "Dealsify",
        "phoneNumber": [
          {
            "phone": "+911234567890"
          }
        ],
        "opening_balance": 2000,
        "gst_in": "24AAACH7409R2Z6",
        "website": "dealsify.in",
        "email": "dealsify@gmail.com",
        "notes": "<p>Dealsify Customer</p>",
        "open_balance_type": "credit",
        "same_as_biling": true,
        "billingAddress": {
          "country": {
            "id": "101",
            "name": "India"
          },
          "state": {
            "id": "4030",
            "name": "Gujarat"
          },
          "city": "Rajkot",
          "pincode": "360004",
          "addressLine1": "Mavdi",
          "addressLine2": "main",
          "addressLine3": "road"
        },
        "shippingAddress": {
          "country": {
            "id": "101",
            "name": "India"
          },
          "state": {
            "id": "4030",
            "name": "Gujarat"
          },
          "city": "Rajkot",
          "pincode": "360004",
          "addressLine1": "Mavdi",
          "addressLine2": "main",
          "addressLine3": "road"
        },
        "company_id": "64f02d9ae92067d72a522c6e",
        "user_id": "6585723e966c57e76be60372",
        "created_id": "6585723e966c57e76be60372",
        "updated_id": "64f02d9ae92067d72a522c6e",
        "createdAt": "2024-09-17T04:53:04.113Z",
        "updatedAt": "2024-09-17T09:58:54.658Z",
        "__v": 0,
        "customCustomersFields": [
          {
            "isActive": true,
            "defaultValue": "rt",
            "isRequired": false,
            "label": "ref",
            "labelSlug": "ref_1724222787736",
            "modelType": "customer"
          },
          {
            "isActive": true,
            "defaultValue": "rty",
            "isRequired": true,
            "label": "rt6y",
            "labelSlug": "stead_1724223210423",
            "modelType": "item"
          },
          {
            "isActive": true,
            "defaultValue": "WSDF",
            "isRequired": false,
            "label": "wse",
            "labelSlug": "wse_1724224730990",
            "modelType": "proforma-invoice"
          }
        ],
      },
      "productionOrderStatus": {
        "_id": "66f3aea449b3c93e29e8809f",
        "companyId": "64f02d9ae92067d72a522c6e",
        "statusLabel": "Waiting for BOM Approval",
        "statusColor": "#2bc1ab",
        "isActive": true,
        "priority": "1",
        "userId": "6585723e966c57e76be60372",
        "createdId": "6585723e966c57e76be60372",
        "createdAt": "2024-09-25T06:33:08.191Z",
        "__v": 0,
        "updatedAt": "2024-09-25T06:33:08.206Z"
      },
      "items": [
        {
          "categoryId": "66e90cc7a2a2c0e20ab07bde",
          "categoryName": "DELL",
          "itemId": "67053d453184c205f089b31a",
          "itemName": "test vercel 1",
          "unitId": "64f02d9a63502d506f62af45",
          "unitName": "BAG",
          "qty": 1,
          "productionMeta": [
            {
              "serialNo": "1",
              "srRange": "1",
              "groupedBOMItems": [],
              "customOrderFields": [],
              "productionStages": [
                {
                  "stageId": "65b345cd97f3f76bcc37741f",
                  "label": "New Stage",
                  "priority": 1,
                  "inspector": "Satish",
                  "isStageCompleted": false,
                  "productionChildStages": [
                    {
                      "label": "New Stage",
                      "labelSlug": "new_stage_1706247650184",
                      "isRequired": false,
                      "priority": 1,
                      "approxProcessTimeInHours": 0,
                      "_id": "65b345e197f3f76bcc3774d6"
                    }
                  ],
                  "mandatoryStages": [
                    "New Stage",
                    "HEADSTOCK ASSEMBLY",
                    "DRILLING ",
                    "MARKING SADDLE & SURFACE"
                  ],
                  "_id": "67075d19720ddf065bb9f382"
                },
                {
                  "stageId": "64fef972b960ea105ed0d931",
                  "label": "MARKING SADDLE & SURFACE",
                  "priority": 1,
                  "inspector": "BHAGABAPA",
                  "isStageCompleted": false,
                  "productionChildStages": [
                    {
                      "label": "SADDLE MARKING",
                      "labelSlug": "marking_saddle___surface_1706244193877",
                      "worker": "MANSUKH",
                      "isRequired": true,
                      "priority": 1,
                      "approxProcessTimeInHours": 0,
                      "_id": "65b3386097f3f76bcc36f9f3"
                    },
                    {
                      "label": "SURFACE MARKING ",
                      "labelSlug": "marking_saddle___surface_1706244193877",
                      "worker": "MANSUKH",
                      "isRequired": true,
                      "priority": 2,
                      "approxProcessTimeInHours": 0,
                      "_id": "65b3386097f3f76bcc36f9f4"
                    },
                    {
                      "label": "SADDLE PATTI",
                      "labelSlug": "marking_saddle___surface_1706244193877",
                      "worker": "MUNNO",
                      "isRequired": true,
                      "priority": 3,
                      "approxProcessTimeInHours": 0,
                      "_id": "65b3386097f3f76bcc36f9f5"
                    },
                    {
                      "label": "SURFACE FAHARI",
                      "labelSlug": "marking_saddle___surface_1706244193877",
                      "worker": "DINESH",
                      "isRequired": false,
                      "priority": 4,
                      "approxProcessTimeInHours": 0,
                      "_id": "65b3386097f3f76bcc36f9f6"
                    }
                  ],
                  "mandatoryStages": [
                    "HEADSTOCK ASSEMBLY",
                    "DRILLING ",
                    "MARKING SADDLE & SURFACE"
                  ],
                  "_id": "67075d19720ddf065bb9f384"
                },
                {
                  "stageId": "64fef9eab960ea105ed0d963",
                  "label": "DRILLING ",
                  "priority": 2,
                  "inspector": "JAYSUKH",
                  "isStageCompleted": false,
                  "productionChildStages": [
                    {
                      "label": "BED DRILLING",
                      "labelSlug": "drilling_1694431722107",
                      "isRequired": true,
                      "priority": 1,
                      "approxProcessTimeInHours": 0,
                      "_id": "64fef9eab960ea105ed0d964"
                    },
                    {
                      "label": "SADDLE DRILLING ",
                      "labelSlug": "drilling_1694431722107",
                      "isRequired": true,
                      "priority": 2,
                      "approxProcessTimeInHours": 0,
                      "_id": "64fef9eab960ea105ed0d965"
                    },
                    {
                      "label": "SURFACE DRILLING",
                      "labelSlug": "drilling_1694431722107",
                      "isRequired": true,
                      "priority": 3,
                      "approxProcessTimeInHours": 0,
                      "_id": "64fef9eab960ea105ed0d966"
                    },
                    {
                      "label": "SADDLE PATTI DRILLING",
                      "labelSlug": "drilling_1694431722107",
                      "isRequired": false,
                      "priority": 4,
                      "approxProcessTimeInHours": 0,
                      "_id": "64fef9eab960ea105ed0d967"
                    }
                  ],
                  "mandatoryStages": [
                    "MARKING SADDLE & SURFACE"
                  ],
                  "_id": "67075d19720ddf065bb9f389"
                },
                {
                  "stageId": "64fefa57b960ea105ed0d9a8",
                  "label": "HEADSTOCK ASSEMBLY",
                  "priority": 5,
                  "inspector": "DAYU",
                  "isStageCompleted": false,
                  "productionChildStages": [
                    {
                      "label": "HEADSTOCK DRILLING",
                      "labelSlug": "headstock_assembly_1706244185507",
                      "isRequired": true,
                      "priority": 1,
                      "approxProcessTimeInHours": 0,
                      "_id": "65b3385897f3f76bcc36f9ba"
                    },
                    {
                      "label": "HEADSTOCK COLORING",
                      "labelSlug": "headstock_assembly_1706244185507",
                      "isRequired": true,
                      "priority": 2,
                      "approxProcessTimeInHours": 0,
                      "_id": "65b3385897f3f76bcc36f9bb"
                    },
                    {
                      "label": "SPINDLE DRILLING",
                      "labelSlug": "headstock_assembly_1706244185507",
                      "isRequired": true,
                      "priority": 3,
                      "approxProcessTimeInHours": 0,
                      "_id": "65b3385897f3f76bcc36f9bc"
                    },
                    {
                      "label": "HEADSTOCK ASSEMBLY",
                      "labelSlug": "headstock_assembly_1706244185507",
                      "isRequired": false,
                      "priority": 5,
                      "approxProcessTimeInHours": 0,
                      "_id": "65b3385897f3f76bcc36f9bd"
                    },
                    {
                      "label": "HEADSTOCK ALIGNMENT",
                      "labelSlug": "headstock_assembly_1706244185507",
                      "isRequired": false,
                      "priority": 7,
                      "approxProcessTimeInHours": 0,
                      "_id": "65b3385897f3f76bcc36f9be"
                    }
                  ],
                  "mandatoryStages": [
                    "HEADSTOCK ASSEMBLY",
                    "DRILLING ",
                    "MARKING SADDLE & SURFACE"
                  ],
                  "_id": "67075d19720ddf065bb9f38e"
                },
                {
                  "stageId": "67065f420b50e393d935825d",
                  "label": "Buffing",
                  "priority": 6,
                  "inspector": "Utsav",
                  "isStageCompleted": false,
                  "productionChildStages": [
                    {
                      "label": "Buffing",
                      "labelSlug": "buffing_1728470843696",
                      "worker": "Utsav",
                      "isRequired": false,
                      "priority": 6,
                      "approxProcessTimeInHours": 0,
                      "_id": "67065f420b50e393d935825e"
                    }
                  ],
                  "mandatoryStages": [
                    "DRILLING "
                  ],
                  "_id": "67075d19720ddf065bb9f394"
                },
                {
                  "stageId": "67065f4c1ea45b1cbebf49e0",
                  "label": "Buffing",
                  "priority": 6,
                  "inspector": "Utsav",
                  "isStageCompleted": false,
                  "productionChildStages": [
                    {
                      "label": "Buffing",
                      "labelSlug": "buffing_1728470853300",
                      "worker": "Utsav",
                      "isRequired": false,
                      "priority": 6,
                      "approxProcessTimeInHours": 0,
                      "_id": "67065f4c1ea45b1cbebf49e1"
                    }
                  ],
                  "mandatoryStages": [
                    "DRILLING "
                  ],
                  "_id": "67075d19720ddf065bb9f396"
                }
              ],
              "headerArray": {
                "headers": [
                  {
                    "headerLabel": "df",
                    "headerId": "66fe992fc7479ef697797b49",
                    "_id": "67075d19720ddf065bb9f398"
                  },
                  {
                    "headerLabel": "test",
                    "headerId": "66fe992fc7479ef697797b48",
                    "_id": "67075d19720ddf065bb9f399"
                  }
                ],
                "labels": [
                  {
                    "label": "Testing",
                    "headerId": {
                      "_id": "66e97c5560f789dd6a3e43a5",
                      "headerLabel": "Header 1"
                    },
                    "value": "1",
                    "_id": "67075d19720ddf065bb9f39a"
                  },
                  {
                    "label": "Testing 2",
                    "headerId": {
                      "_id": "66e97c5560f789dd6a3e43a5",
                      "headerLabel": "Header 1"
                    },
                    "value": "1",
                    "_id": "67075d19720ddf065bb9f39b"
                  },
                  {
                    "label": "Testing 2",
                    "headerId": {
                      "_id": "66e97c5560f789dd6a3e43a6",
                      "headerLabel": "Header 2"
                    },
                    "value": "2",
                    "_id": "67075d19720ddf065bb9f39c"
                  }
                ]
              },
              "machineValues": [],
              "dispatchValues": [
                {
                  "label": "Dispatch 1",
                  "dispatchId": "66e97c2b60f789dd6a3e4384",
                  "_id": "67075d19720ddf065bb9f39d"
                }
              ],
              "_id": "67075d19720ddf065bb9f381"
            }
          ],
          "_id": "67075d19720ddf065bb9f380"
        }
      ],
    }
  ],
  "total": 19,
  "status": true
};
