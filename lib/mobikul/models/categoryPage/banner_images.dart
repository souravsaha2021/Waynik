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
part 'banner_images.g.dart';

@JsonSerializable()
class BannerImages{

  String? url;
  String? dominantColor;
  String? title;
  String? bannerType;
  String? id;
  String? name;

  BannerImages(this.url, this.dominantColor, this.title,
      this.bannerType, this.id, this.name);

  factory BannerImages.fromJson(Map<String, dynamic> json) =>
      _$BannerImagesFromJson(json);

  Map<String, dynamic> toJson() => _$BannerImagesToJson(this);
}