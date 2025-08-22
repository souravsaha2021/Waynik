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

import '../../../models/base_model.dart';
import '../../../network_manager/api_client.dart';

abstract class QrScreenRepository {
  Future<BaseModel> qrScan(String barCodeData);


}

class QrScreenRepositoryImp implements QrScreenRepository {
  @override
  Future<BaseModel> qrScan(String barCodeData) async {
    var responseData = await ApiClient().qrScan(barCodeData);
    return responseData!;
  }


}
