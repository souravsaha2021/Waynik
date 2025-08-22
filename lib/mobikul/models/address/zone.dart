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

part 'zone.g.dart';

@JsonSerializable()
class Zone {
  @JsonKey(name: "zone_id")
  String? zoneId;

  @JsonKey(name: "name")
  String? name;

  Zone({this.zoneId, this.name});

  factory Zone.fromJson(Map<String, dynamic> json) => _$ZoneFromJson(json);

  Map<String, dynamic> toJson() => _$ZoneToJson(this);
}
