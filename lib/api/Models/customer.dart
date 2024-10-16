
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
