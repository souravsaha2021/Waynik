// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_boy_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryBoyDetailsModel _$DeliveryBoyDetailsModelFromJson(
        Map<String, dynamic> json) =>
    DeliveryBoyDetailsModel(
      assignedDeliveryBoyDetails: (json['assignedDeliveryBoyDetails']
              as List<dynamic>?)
          ?.map((e) =>
              AssignedDeliveryBoyDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      customerAddress: json['customerAddress'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$DeliveryBoyDetailsModelToJson(
        DeliveryBoyDetailsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'assignedDeliveryBoyDetails': instance.assignedDeliveryBoyDetails,
      'customerAddress': instance.customerAddress,
    };

AssignedDeliveryBoyDetails _$AssignedDeliveryBoyDetailsFromJson(
        Map<String, dynamic> json) =>
    AssignedDeliveryBoyDetails(
      name: json['name'] as String?,
      email: json['email'] as String?,
      status: json['status'],
      mobileNumber: json['mobileNumber'] as String?,
      address: json['address'],
      deliveryBoyLat: json['deliveryBoyLat'],
      deliveryBoyLong: json['deliveryBoyLong'],
      vehicleType: json['vehicleType'] as String?,
      onlineStatus: json['onlineStatus'],
      vehicleNumber: json['vehicleNumber'] as String?,
      picked: json['picked'] as bool?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isEligibleForDeliveryBoy: json['isEligibleForDeliveryBoy'] as bool?,
      customerId: (json['customerId'] as num?)?.toInt(),
      rating: json['rating'],
      avatar: json['avatar'] as String?,
      sellerId: (json['sellerId'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      otp: (json['otp'] as num?)?.toInt(),
      shippingAddress: json['shippingAddress'] as String?,
      warehouse: json['warehouse'] as String?,
      warehouseLat: json['warehouseLat'] as String?,
      warehouseLong: json['warehouseLong'] as String?,
    )..selectedRating = (json['selectedRating'] as num?)?.toDouble();

Map<String, dynamic> _$AssignedDeliveryBoyDetailsToJson(
        AssignedDeliveryBoyDetails instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'status': instance.status,
      'mobileNumber': instance.mobileNumber,
      'address': instance.address,
      'deliveryBoyLat': instance.deliveryBoyLat,
      'deliveryBoyLong': instance.deliveryBoyLong,
      'vehicleType': instance.vehicleType,
      'onlineStatus': instance.onlineStatus,
      'vehicleNumber': instance.vehicleNumber,
      'picked': instance.picked,
      'products': instance.products,
      'isEligibleForDeliveryBoy': instance.isEligibleForDeliveryBoy,
      'customerId': instance.customerId,
      'rating': instance.rating,
      'avatar': instance.avatar,
      'sellerId': instance.sellerId,
      'id': instance.id,
      'otp': instance.otp,
      'selectedRating': instance.selectedRating,
      'shippingAddress': instance.shippingAddress,
      'warehouse': instance.warehouse,
      'warehouseLat': instance.warehouseLat,
      'warehouseLong': instance.warehouseLong,
    };
