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

part 'billing_address_datum.g.dart';

@JsonSerializable()
class BillingAddressDatum {
  /*  addressId: json['id'] as String?,
  value: json['addressTitle'] as String?,
  value: json['value'] as String?,*/

  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "addressTitle")
  String? addressTitle;

  @JsonKey(name: "value")
  String? value;

  BillingAddressDatum({this.id, this.addressTitle, this.value});

  factory BillingAddressDatum.fromJson(Map<String, dynamic> json) =>
      _$BillingAddressDatumFromJson(json);

  Map<String, dynamic> toJson() => _$BillingAddressDatumToJson(this);
}
