class PricingPlan {
  bool? success;
  String? message;
  List<PricingPlan>? data;

  PricingPlan({this.success, this.message, this.data});

  PricingPlan.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PricingPlan>[];
      json['data'].forEach((v) {
        data!.add(PricingPlan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
