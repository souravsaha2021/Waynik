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

part 'image_gallery.g.dart';
@JsonSerializable()
class ImageGallery{
  String? smallImage;
  String? largeImage;
  String? dominantColor;
  bool? isVideo;
  String? videoUrl;


  ImageGallery(this.smallImage, this.largeImage, this.dominantColor,
      this.isVideo, this.videoUrl);

  factory ImageGallery.fromJson(Map<String, dynamic> json) =>
      _$ImageGalleryFromJson(json);

  Map<String, dynamic> toJson() => _$ImageGalleryToJson(this);

}