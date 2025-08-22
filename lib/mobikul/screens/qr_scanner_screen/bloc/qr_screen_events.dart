/*
* Webkul Software.
*
@package Mobikul Application Code.
* @Category Mobikul
* @author Webkul <support@webkul.com>
* @Copyright (c) Webkul Software Private Limited (https://webkul.com)
* @license https://store.webkul.com/license.html
* @link https://store.webkul.com/license.html
*
*/

import 'package:equatable/equatable.dart';

abstract class QrScreenEvent extends Equatable{
  const QrScreenEvent();

  @override
  List<Object> get props => [];
}

class QrScreenDataFetchEvent extends QrScreenEvent{
  const QrScreenDataFetchEvent();
}

class QrScanSuccessEvent extends QrScreenEvent{
  String barCodeData;
  QrScanSuccessEvent(this.barCodeData);
}

