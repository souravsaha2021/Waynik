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

import '../../../models/base_model.dart';

abstract class QrScreenState extends Equatable {
  const QrScreenState();

  @override
  List<Object> get props => [];
}

class QrScreenInitial extends QrScreenState{}

class QrScreenSuccess extends QrScreenState{
  const QrScreenSuccess();
}

class QrScreenError extends QrScreenState{
  final String message;
  const QrScreenError(this.message);
}

class QrScanScreen extends QrScreenState{
  final BaseModel response;

  QrScanScreen(this.response);

}

class QrScreenEmptyState extends QrScreenState{

}


