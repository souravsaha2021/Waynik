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

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_new/mobikul/models/order_details/order_detail_model.dart';

import '../../../models/shipment_view/shipment_view_model.dart';
import '../../../network_manager/api_client.dart';

abstract class OrderShipmentScreenRepository {
  Future<ShipmentViewModel> getShipmentView(String shipmentId);
}

class OrderShipmentScreenRepositoryImp implements OrderShipmentScreenRepository {
  @override
  Future<ShipmentViewModel> getShipmentView(String shipmentId) async {
    ShipmentViewModel? shipmentListData;
    try {
      shipmentListData = await ApiClient().getShipmentView(shipmentId);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
    return shipmentListData!;
  }
}
