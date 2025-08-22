/*
 *
 *  Webkul Software.
 * @package Mobikul Application Code.
 *  @Category Mobikul
 *  @author Webkul <support@webkul.com>
 *  @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *  @license https://store.webkul.com/license.html
 *  @link https://store.webkul.com/license.html
 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';

import '../base_model.dart';
part 'delivery_boy_details_model.g.dart';

@JsonSerializable()
class DeliveryBoyDetailsModel extends BaseModel{

  @JsonKey(name:"assignedDeliveryBoyDetails")
  List<AssignedDeliveryBoyDetails>? assignedDeliveryBoyDetails;
  String? customerAddress;



  DeliveryBoyDetailsModel({
    this.assignedDeliveryBoyDetails,
    this.customerAddress

  });
  factory DeliveryBoyDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryBoyDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryBoyDetailsModelToJson(this);
}

@JsonSerializable()
class AssignedDeliveryBoyDetails {
  @JsonKey(name:"name")
  String? name;

  @JsonKey(name:"email")
  String? email;

  @JsonKey(name:"status")
  dynamic? status;

  @JsonKey(name:"mobileNumber")
  String? mobileNumber;

  @JsonKey(name:"address")
  dynamic? address;

  @JsonKey(name:"deliveryBoyLat")
  dynamic? deliveryBoyLat;

  @JsonKey(name:"deliveryBoyLong")
  dynamic? deliveryBoyLong;

  @JsonKey(name:"vehicleType")
  String? vehicleType;

  @JsonKey(name:"onlineStatus")
  dynamic? onlineStatus;

  @JsonKey(name:"vehicleNumber")
  String? vehicleNumber;

  @JsonKey(name:"picked")
  bool? picked;

  @JsonKey(name:"products")
  List<String>? products;

  @JsonKey(name:"isEligibleForDeliveryBoy")
  bool? isEligibleForDeliveryBoy = false;

  @JsonKey(name:"customerId")
  int? customerId;

  @JsonKey(name:"rating")
  dynamic? rating;

  @JsonKey(name:"avatar")
  String? avatar;

  @JsonKey(name:"sellerId")
  int? sellerId;

  @JsonKey(name:"id")
  int? id;

  @JsonKey(name:"otp")
  int? otp;

  double? selectedRating = 0.0;

  String? shippingAddress;

  @JsonKey(name: "warehouse")
  String? warehouse;

  @JsonKey(name: "warehouseLat")
  String? warehouseLat;

  @JsonKey(name: "warehouseLong")
  String? warehouseLong;


  AssignedDeliveryBoyDetails({
      this.name,
      this.email,
      this.status,
      this.mobileNumber,
      this.address,
      this.deliveryBoyLat,
      this.deliveryBoyLong,
      this.vehicleType,
      this.onlineStatus,
      this.vehicleNumber,
      this.picked,
      this.products,
      this.isEligibleForDeliveryBoy,
      this.customerId,
      this.rating,
      this.avatar,
      this.sellerId,
      this.id,
      this.otp,
    this.shippingAddress,
    this.warehouse,
    this.warehouseLat,
    this.warehouseLong
  });

  factory AssignedDeliveryBoyDetails.fromJson(Map<String, dynamic> json) =>
      _$AssignedDeliveryBoyDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AssignedDeliveryBoyDetailsToJson(this);
}
