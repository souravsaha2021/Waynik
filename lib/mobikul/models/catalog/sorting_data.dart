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

part 'sorting_data.g.dart';

@JsonSerializable()
class SortingData {
  @JsonKey(name: "code")
  String? code;

  @JsonKey(name: "label")
  String? label;

  String? direction;

  SortingData({
    this.code,
    this.label,
    this.direction,
  });


  @override
  String toString() {
    return 'Sort{text: $code, value: $label, value: $direction}';
  }

  factory SortingData.fromJson(Map<String, dynamic> json) => _$SortingDataFromJson(json);

  Map<String, dynamic> toJson() => _$SortingDataToJson(this);
}
