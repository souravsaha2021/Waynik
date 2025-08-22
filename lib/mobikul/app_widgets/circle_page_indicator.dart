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

import 'package:flutter/material.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';

class CirclePageIndicator extends StatefulWidget {
  static const double _defaultSize = 6.0;
  static const double _defaultSelectedSize = 6.0;
  static const double _defaultSpacing = 8.0;
  static const Color _defaultDotColor = Color(0x509E9E9E);
  static const Color _defaultSelectedDotColor = Colors.grey;

  /// The current page index ValueNotifier
  final ValueNotifier<int>? currentPageNotifier;

  /// The number of items managed by the PageController
  final int? itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int>? onPageSelected;

  ///The dot color
  final Color dotColor;

  ///The selected dot color
  final Color selectedDotColor;

  ///The normal dot size
  final double size;

  ///The selected dot size
  final double selectedSize;

  ///The space between dots
  final double dotSpacing;

  CirclePageIndicator({
    // Key? key,
    @required this.currentPageNotifier,
    @required this.itemCount,
    this.onPageSelected,
    this.size = _defaultSize,
    this.dotSpacing = _defaultSpacing,
    this.selectedSize = _defaultSelectedSize,required this.dotColor,required this.selectedDotColor
  });
      // : this.dotColor = dotColor ??
      // ((selectedDotColor?.withAlpha(150)) ?? _defaultDotColor),
      //   this.selectedDotColor = selectedDotColor ?? AppColors.black,
      //   super(key: key);

  @override
  CirclePageIndicatorState createState() {
    return new CirclePageIndicatorState();
  }
}

class CirclePageIndicatorState extends State<CirclePageIndicator> {
  int _currentPageIndex = 0;

  @override
  void initState() {
    _readCurrentPageIndex();
    widget.currentPageNotifier!.addListener(_handlePageIndex);
    super.initState();
  }

  @override
  void dispose() {
    widget.currentPageNotifier!.removeListener(_handlePageIndex);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: List<Widget>.generate(widget.itemCount!, (int index) {
          double size = widget.size;
          Color color = widget.dotColor;
          if (isSelected(index)) {
            size = widget.selectedSize;
            color = widget.selectedDotColor;
          }
          return GestureDetector(
            onTap: () => widget.onPageSelected == null
                ? null
                : widget.onPageSelected!(index),
            child: Container(
              width: size + widget.dotSpacing,
              decoration:  BoxDecoration(
                shape: BoxShape.circle,
                    color: (_currentPageIndex == index)
                        ? AppColors.darkGray : null ,
              ) ,
              padding: const EdgeInsets.all(3.0),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (_currentPageIndex == index) ?  AppColors.white : AppColors.darkGray
                ) ,
                width: size ,
                height: size,
              ),
            ),
          );
        }));
  }

  bool isSelected(int dotIndex) => _currentPageIndex == dotIndex;

  _handlePageIndex() {
    setState(_readCurrentPageIndex);
  }

  _readCurrentPageIndex() {
    _currentPageIndex = widget.currentPageNotifier!.value;
  }
}
