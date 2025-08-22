
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

part of 'order_detail_screen_bloc.dart';

abstract class OrderDetailState extends Equatable{
  const OrderDetailState();

  @override
  List<Object> get props => [];
}

class OrderDetailInitial extends OrderDetailState{

}

class OrderDetailEmptyState extends OrderDetailState{}

class OrderDetailSuccess extends OrderDetailState{
  OrderDetailModel? model;
  OrderDetailSuccess(this.model);

  @override
  List<Object> get props => [];
}

class DeliveryBoyDetailSuccess extends OrderDetailState{
  DeliveryBoyDetailsModel? model;
  DeliveryBoyDetailSuccess(this.model);

  @override
  List<Object> get props => [];
}

class AddProductToCartStateSuccess extends OrderDetailState {
  AddProductToCartStateSuccess(this.baseModel);

  BaseModel baseModel;

  @override
  List<Object> get props => [];
}

class OrderDetailError extends OrderDetailState {
  OrderDetailError(this._message);

  String? _message;

  // ignore: unnecessary_getters_setters
  String? get message => _message;

  // ignore: unnecessary_getters_setters
  set message(String? message) {
    _message = message;
  }

  @override
  List<Object> get props => [];
}
class ReorderSuccessState extends OrderDetailState{
  final BaseModel response;
  const ReorderSuccessState(this.response);
}