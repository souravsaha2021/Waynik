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

import '../../../models/shipment_view/shipment_view_model.dart';

abstract class ViewOrderShipmentState extends Equatable{
  const ViewOrderShipmentState();

  @override
  List<Object> get props => [];
}


class ViewOrderShipmentInitial extends ViewOrderShipmentState{}

class ViewOrderShipmentSuccess extends ViewOrderShipmentState{
  final ShipmentViewModel shipmentViewModel;
  const ViewOrderShipmentSuccess(this.shipmentViewModel);
}

class ViewOrderShipmentError extends ViewOrderShipmentState{
  final String message;
  const ViewOrderShipmentError(this.message);
}

