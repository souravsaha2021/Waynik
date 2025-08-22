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

// ignore_for_file: file_names, must_call_super, unused_field

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/helper/utils.dart';

import '../../../app_widgets/app_multi_select_checkbox.dart';
import '../../../app_widgets/common_widgets.dart';
import '../../../app_widgets/radio_button_group.dart';
import '../../../helper/constants_helper.dart';
import '../../../models/productDetail/bundle_option.dart';
import 'group_quantity_view.dart';

// ignore: must_be_immutable
class BundleOptionsView extends StatefulWidget {
  Function(List<dynamic>)? callBack;
  List<BundleOption>? options = [];
  BundleOptionsView({Key? key, this.options, this.callBack}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _BundleOptionsViewState();
  }
}

class _BundleOptionsViewState extends State<BundleOptionsView> {
  // List newData = [];
  String? currentId;
  var bundleData = <dynamic, dynamic>{};
  List<dynamic> mProductParamsJSON = [];
  List<dynamic> mProductParamsJSONData = [];



  // var bundleOption = <dynamic, dynamic>{};
  // var bundleOptionQty = <dynamic, dynamic>{};
  @override
  void initState() {
    print("sdgadfgsdfg");
    // getBundleData();
    // TODO: implement initState
    super.initState();
  }

  getBundleData() {

    print("Fires selectedData---===${mProductParamsJSON}");
    for (int i = 0; i < (widget.options?.length ?? 0); i++) {
      Map<String, dynamic> mProductParams = new Map();
      mProductParams["id"] = widget.options?[i].optionId?.toString() ?? '';
      mProductParams["value"] = widget.options?[i].selectedOption ?? "1";
      mProductParams["qty"] = widget.options?[i].selectedQty ?? "1";
      mProductParamsJSONData.add(mProductParams);

    }

    if (widget.callBack != null) {
      print("mProductParamsJSONData TEST_LOG--> data$mProductParamsJSONData");
      widget.callBack!(mProductParamsJSONData);
    }

  }

  getBundleDataForCheckBoxData({String? selecteddata}){
    for (int i = 0; i < (widget.options?.length ?? 0); i++) {

      for(int j = 0; j < (widget.options?[i].optionValues?.length ?? 0); j++){
        print("sadhff----${widget.options?[i].optionValues}");
        if(selecteddata == widget.options?[i].optionValues?[j].optionValueId){
          print("dhgfadhf come --${widget.options?[i].selectedOption}");

          Map<String, dynamic> mProductParams = new Map();
          mProductParams["id"] = widget.options?[i].optionId?.toString() ?? '';
          mProductParams["value"] = widget.options?[i].selectedOption ?? "1";
          mProductParams["qty"] = widget.options?[i].selectedQty ?? "1";
          mProductParamsJSONData.add(mProductParams);
        }
      }
    }
    mProductParamsJSONData = removeDuplicates(mProductParamsJSONData);


    if (widget.callBack != null) {
      print("TEST_LOG--> data$mProductParamsJSONData");
      var data = mProductParamsJSONData.toSet().toList();
      print("asdghffd---${data}");

      widget.callBack!(mProductParamsJSONData);
    }

    print("hsgdd  data list ----${mProductParamsJSONData}");
  }

  getBundleDataForCheckBokData({String? selecteddata}){
    // mProductParamsJSONData = [];

    print("Fires selectedData---===${mProductParamsJSON}");
    print("Fires mProductParamsJSONData---===${mProductParamsJSONData}");

    print("options-----${widget.options?.length}");


    for (int i = 0; i < (widget.options?.length ?? 0); i++) {

      for(int j = 0; j < (widget.options?[i].optionValues?.length ?? 0); j++){
        print("sadhff----${widget.options?[i].optionValues}");
        if(selecteddata == widget.options?[i].optionValues?[j].optionValueId){
          print("dhgfadhf come --${widget.options?[i].selectedOption}");

          Map<String, dynamic> mProductParams = new Map();
          mProductParams["id"] = widget.options?[i].optionId?.toString() ?? '';
          mProductParams["value"] = widget.options?[i].selectedOption ?? "1";
          mProductParams["qty"] = widget.options?[i].selectedQty ?? "1";
          mProductParamsJSONData.add(removeDuplicatesById(mProductParamsJSONData, mProductParams));

          print("data mProductParamsJSONData---${mProductParamsJSONData}");
        }
      }
    }
    mProductParamsJSONData = removeDuplicates(mProductParamsJSONData);


    print("Updated datat ----${mProductParamsJSONData}");

    print("mProductParamsJSONData removed data-----${mProductParamsJSONData}");
    // mProductParamsJSON =  mProductParamsJSON.toSet().toList();
    if (widget.callBack != null) {
      print("TEST_LOG--> data$mProductParamsJSONData");
      var data = mProductParamsJSONData.toSet().toList();
      print("asdghffd---${data}");

      widget.callBack!(mProductParamsJSONData);
    }

    print("hsgdd  data list ----${mProductParamsJSONData}");


  }

  List<dynamic> removeDuplicates(List<dynamic> list) {
    // Use a set to track unique entries based on their string representation
    Set<String> uniqueEntries = {};
    List<Map<String, dynamic>> uniqueList = [];

    for (var map in list) {
      String mapString = jsonEncode(map);
      if (uniqueEntries.add(mapString)) {
        uniqueList.add(map);
      }
    }

    return uniqueList;
  }

  dynamic removeDuplicatesById(List<dynamic> list, selectedData) {
    int index = list.indexWhere((element) => element["id"] == selectedData["id"]);
    if(index != -1){
      list.removeAt(index);
      print("removed data-------${selectedData}");
      return selectedData;
    } else {
      return selectedData;
    }
  }


  void RemoveMethod({bool? isRemoved,String? selectedData, int? currentIndex}){

    print("-jhsdf-----${selectedData}");
    if(selectedData != null){
      var lenghtData = mProductParamsJSONData?.length ?? 0;
      mProductParamsJSONData.removeWhere((item) => item['value'] == selectedData);
      print("mProductParamsJSONData------${mProductParamsJSONData}");
      if (widget.callBack != null) {
        print("TEST_LOG--> data$mProductParamsJSON");
        widget.callBack!(mProductParamsJSONData);
      }
    }
  }

  dynamic removeDuplicatesByIdTextField(List<dynamic> list, selectedData) {
    int index = list.indexWhere((element) => element["id"] == selectedData);
    if(index != -1){
      list.removeAt(index);
      print("removed data-------${selectedData}");
      return selectedData;
    } else {
      return selectedData;
    }
  }


  @override
  void didChangeDependencies() {}

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text( Utils.getStringValue(context, AppStringConstant.customizeOptions),style: Theme.of(context).textTheme.headline6,),

            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.options?.length ?? 0,
                itemBuilder: (context, index) {
                  var item = widget.options?[index];
                  switch (item?.type ?? '') {
                    case ConstantsHelper.select:
                      return _getTextField(item);
                    case ConstantsHelper.radioText:
                      return _getRadioButtonType(item);
                    case ConstantsHelper.checkBoxText:
                      return _getCheckBoxType(item);
                    case ConstantsHelper.multiSelect:
                      return _getCheckBoxType(item);
                    default:
                      break;
                  }
                  return Container();
                })
          ],
        ));
  }

  Widget _getRadioButtonType(BundleOption? option) {
    return Container(
      // color: Colors.white,
        padding: const EdgeInsets.fromLTRB(
            AppSizes.spacingNormal,
            AppSizes.spacingNormal,
            AppSizes.spacingNormal,
            AppSizes.spacingNormal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              option?.title.toString() ?? '',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(
              height: AppSizes.spacingNormal,
            ),
            Container(
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.0, style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              child: RadioButtonGroup(
                key: Key(option?.optionId?.toString() ?? ''),
                labels:
                option?.optionValues?.map((e) => e.title ?? "").toList(),
                /* activeColor: Colors.black,*/ onChange: (label, index) {
                print("jdfjfjs----${label}");
                if ((option?.optionValues?.length ?? 0) > index) {
                  option?.selectedOption =
                      option.optionValues?[index].optionValueId.toString();

                  print("option?.selectedOption----${option?.selectedOption}");

                  getBundleDataForCheckBokData(selecteddata: option?.selectedOption);

                }
              },
              ),
            ),
            GroupQuantityView(
                qty: option?.required.toString() ?? "1",
                callBack: (qty) {
                  option?.selectedQty = qty.toString();
                  // getBundleData();
                  updateQty(mProductParamsJSONData,option?.optionId ?? "0",option?.selectedOption ?? "0",qty);

                })
          ],
        ));
  }

  void updateQty(List<dynamic> bundleOptions, String id, String value, int newQty) {

    print("ashdad----${mProductParamsJSONData}");

    print("sghdf-----id${id}");
    print("sghdf-----value${value}");

    for (var option in bundleOptions) {
      if (option['id'] == id && option['value'] == value) {
        option['qty'] = newQty;
        print("option Id---${option['id']}");
        print("option Value---${option['value']}");
        print("option qty---${option['qty']}");

        return;
      }
    }
    if (widget.callBack != null) {
      print("TEST_LOG--> data$mProductParamsJSONData");
      var data = mProductParamsJSONData.toSet().toList();
      print("asdghffd---${data}");
      print("asdghffd---${mProductParamsJSONData}");

      // widget.callBack!(mProductParamsJSONData);
    }



    print("Updated list data ----${mProductParamsJSON}");

  }

  Widget _getCheckBoxType(BundleOption? option) {
    return (widget.options?.length ?? 0) > 0
        ? Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            option?.optionValues?.map((e) => e.title).toString() ??
                "" ??
                '',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
            child: CheckboxGroup(
              // activeColor: Colors.black,
              labels: option?.optionValues
                  ?.map((e) => e.title ?? "")
                  .toList(),
              onChange: (isChecked, label, index, key) {
                var product = option?.optionValues
                    ?.firstWhere((element) => element.title == label);
                print("hsvdh---${product?.optionValueId}");
                if (isChecked) {
                  option?.selectedOption = product?.optionValueId ?? "0";
                  // getBundleData();
                  getBundleDataForCheckBoxData(selecteddata: option?.selectedOption);
                  // _updateQtyValue(int.parse(option?.optionId??"" )?? 0, product?.defaultQty?.toString() ?? '0');
                  // _updateOptions(int.parse(option?.optionId??"") ?? 0,int.parse(product?.optionId??"") ?? 0,-1,false);
                } else {
                  print("index----${index}");
                  print("jfsfdsfshfh--");
                  print("Data-----${option?.selectedOption}");
                  print("Data-----${option?.optionValues}");

                  RemoveMethod(isRemoved: true,selectedData:product?.optionValueId,currentIndex:index);

                  // _updateOptions(int.parse(option?.optionId??"") ?? 0,-1,int.parse(product?.optionId??"") ?? 0,false);
                }
              },
            ),
          ),
          Visibility(
            visible: ((option?.type != ConstantsHelper.checkBoxText ) && (option?.type != ConstantsHelper.multiSelect)) ? true : false,
            child: GroupQuantityView(
                qty: option?.required.toString() ?? "1",
                callBack: (qty) {
                  if(mProductParamsJSON.length <=1 ){
                    mProductParamsJSON.clear();
                  }
                  option?.selectedQty = qty.toString();
                  print("shdgajd----option?.selectedQty  ${option?.selectedQty}");
                  getBundleData();
                  // _updateQtyValue(int.parse(option?.optionId??"") ?? 0, qty /*?? 0*/);
                }),
          )
        ])
        : Container();
  }

  Widget _getTextField(BundleOption? option) {
    return Container(
      // color: Colors.white,
        padding: const EdgeInsets.fromLTRB(
            AppSizes.spacingNormal,
            AppSizes.spacingNormal,
            AppSizes.spacingNormal,
            AppSizes.spacingNormal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: CommonWidgets().getDropdown(
                  Key(option?.optionId?.toString() ?? ''),
                  context,
                  option?.optionValues?.map((e) => e.title ?? "").toList() ??
                      [],
                  /*  option?.bundleOptionProducts?.map((e) => e.name ?? '').toList() ?? []*/
                  option?.optionValues?.map((e) => e.title).toString(),
                  null,
                  null,
                  option?.optionValues?.map((e) => e.title).toString(),
                      (label, key) {
                    var product = option?.optionValues
                        ?.firstWhere((element) => element.title == label);

                    option?.selectedOption = product?.optionValueId ?? "0";
                    print("optionValueId------${product?.optionValueId}");
                    print("mProductParamsJSONData After Removed----${mProductParamsJSONData}");
                    getBundleDataForCheckBokData(selecteddata: option?.selectedOption);
                  }, false),
            ),
            GroupQuantityView(
                qty: option?.required.toString() ?? "1",
                callBack: (qty) {
                  option?.selectedQty = qty.toString();
                  updateQty(mProductParamsJSONData,option?.optionId ?? "0",option?.selectedOption ?? "0",qty);
                })
          ],
        ));
  }

  _updateOptions(int id, int productId, int removeId, bool isReplace) {
    if (bundleData["bundle_options"] != null) {
      if (bundleData["bundle_options"][id.toString()] != null) {
        if (removeId != -1) {}
        (bundleData["bundle_options"]?[id.toString()] as List<dynamic>)
            .remove(removeId);

        if (productId != -1) {
          if (isReplace) {
            bundleData["bundle_options"][id.toString()] = [productId];
          } else {
            (bundleData["bundle_options"][id.toString()] as List<dynamic>)
                .add(productId);
          }
        }
      } else {
        bundleData["bundle_options"][id.toString()] = [productId];
      }
    } else {
      bundleData["bundle_options"] = {
        id.toString(): [productId]
      };
    }
  }

  _updateQtyValue(int id, dynamic qty) {
    if (bundleData["bundle_option_qty"] != null) {
      setState(() {
        (bundleData["bundle_option_qty"]
        as Map<String, dynamic>?)?[id.toString() /*?? ""*/] = qty;
      });
    } else {
      setState(() {
        bundleData["bundle_option_qty"] = {id.toString(): qty};
      });
    }
  }
}

class BundleData {
  String? bundleOptionId;
  String? bundleOptionProductId;
  int? qty;

  BundleData({this.bundleOptionId, this.bundleOptionProductId, this.qty});
  factory BundleData.fromJson(Map<String, dynamic> json) => BundleData(
    bundleOptionId: json["bundleOptionId"] ?? null,
    bundleOptionProductId: json["bundleOptionProductId"] == null
        ? null
        : json["bundleOptionProductId"],
    qty: json["qty"] == null ? null : json["qty"],
  );
  Map<String, dynamic> toJson() => {
    "bundleOptionId": bundleOptionId == null ? null : bundleOptionId,
    "bundleOptionProductId":
    bundleOptionProductId == null ? null : bundleOptionProductId,
    "qty": qty == null ? null : qty,
  };
}
