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

part 'orders_and_returns_model.g.dart';

@JsonSerializable()
class OrdersAndReturnsModel extends BaseModel{
  String? email;
  String? orderId;
  String? billingLastName;
  String? findOrderBy;
  String? billingZipCode;

  OrdersAndReturnsModel({
    required this.email,
    required this.orderId,
    this.billingLastName,
    this.findOrderBy,
    this.billingZipCode
});

  factory OrdersAndReturnsModel.fromJson(Map<String, dynamic> json) =>
      _$OrdersAndReturnsModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersAndReturnsModelToJson(this);
}