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
part 'rating_array.g.dart';
@JsonSerializable()
class RatingArray{
  @JsonKey(name:"1")
  double? one;

  @JsonKey(name:"2")
  double? two;

  @JsonKey(name:"3")
  double? three;

  @JsonKey(name:"4")
  double? four;

  @JsonKey(name:"5")
  double? five;

  RatingArray(this.one, this.two, this.three, this.four, this.five);

  factory RatingArray.fromJson(Map<String, dynamic> json) =>
      _$RatingArrayFromJson(json);

  Map<String, dynamic> toJson() => _$RatingArrayToJson(this);
}