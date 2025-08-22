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

import 'package:equatable/equatable.dart';
import '../../../models/download_product/download_product.dart';
import '../../../models/downloadable_products/downloadable_products_list_model.dart';

abstract class DownloadableProductsScreenState  {
  const DownloadableProductsScreenState();

  @override
  List<Object> get props => [];
}

class DownloadableProductsScreenInitial extends DownloadableProductsScreenState{}

class DownloadableProductsScreenSuccess extends DownloadableProductsScreenState {
  final DownloadableProductsListModel downloadableProductsListModel;

  const DownloadableProductsScreenSuccess(this.downloadableProductsListModel);
}


class DownloadProductSuccess extends DownloadableProductsScreenState {
  final DownloadProduct downloadProduct;

  const DownloadProductSuccess(this.downloadProduct);
}

class DownloadableProductsScreenError extends DownloadableProductsScreenState{
  final String message;
  const DownloadableProductsScreenError(this.message);
}

class  DownloadableProductsEmptyState extends DownloadableProductsScreenState {

}


