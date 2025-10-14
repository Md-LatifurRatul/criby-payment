class PricingData {
  int? id;
  String? name;
  String? slug;
  String? description;
  int? price;
  int? charge;
  int? durationDays;
  int? dataLimit;

  PricingData({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.price,
    this.charge,
    this.durationDays,
    this.dataLimit,
  });

  PricingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    price = json['price'];
    charge = json['charge'];
    durationDays = json['duration_days'];
    dataLimit = json['data_limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['description'] = description;
    data['price'] = price;
    data['charge'] = charge;
    data['duration_days'] = durationDays;
    data['data_limit'] = dataLimit;
    return data;
  }
}
