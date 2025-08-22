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

abstract class CartScreenEvent extends Equatable{
  const CartScreenEvent();

  @override
  List<Object> get props => [];
}

class CartScreenDataFetchEvent extends CartScreenEvent {
  const CartScreenDataFetchEvent();

  @override
  List<Object> get props => [];
}

class RemoveCartItem extends CartScreenEvent{
  final String lineId;
   const RemoveCartItem(this.lineId);
  @override
  List<Object> get props => [];
}

class CartToWishlistEvent extends CartScreenEvent{
  final String itemId;
  final String productId;
  final String qty;

  const CartToWishlistEvent(this.itemId,this.productId, this.qty);
}

class SetCartEmpty extends CartScreenEvent{

  const SetCartEmpty();
}

class SetCartItemQuantityEvent extends CartScreenEvent{
  final String lineId;
  final int qty;
  final int currentQty;

  const SetCartItemQuantityEvent(this.lineId,this.qty, this.currentQty);
}

class ApplyCouponEvent extends CartScreenEvent{
  String couponCode;
  final int remove;

  ApplyCouponEvent(this.couponCode, this.remove);
}
