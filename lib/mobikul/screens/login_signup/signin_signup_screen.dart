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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/mobikul/app_widgets/app_bar.dart';
import 'package:test_new/mobikul/app_widgets/app_outlined_button.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/helper/bottom_sheet_helper.dart';
import 'package:test_new/mobikul/helper/utils.dart';
import 'package:path_provider/path_provider.dart' as path;

import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/loader.dart';
import '../../constants/app_routes.dart';
import '../../helper/app_storage_pref.dart';
import '../../models/dashboard/UserDataModel.dart';
import 'bloc/signin_signup_screen_bloc.dart';

class SignInSignUpScreen extends StatefulWidget {
  const SignInSignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignInSignUpScreen> createState() => _SignInSignUpScreenState();
}

class _SignInSignUpScreenState extends State<SignInSignUpScreen> {
  SigninSignupScreenBloc? bloc;
  late bool _loading;

  @override
  void initState() {
    bloc = context.read<SigninSignupScreenBloc>();
    _loading = false;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildContent(),
      ],
    );
  }

  Widget _buildContent() {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // appBar: commonAppBar(Utils.getStringValue(context, AppStringConstant.signInRegister), context),
     /* appBar: commonAppBar(
          Utils.getStringValue(context, AppStringConstant.signInRegister),
          context,
          isLeadingEnable: false),*/

      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingMedium),
        child: SafeArea(
          child: BlocBuilder<SigninSignupScreenBloc, SigninSignupScreenState>(
              builder: (event, state) {
            if (state is SignupScreenFormSuccess) {
              _loading = false;
              var model = state.data;
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showSuccess(model.message ?? "", context);
                appStoragePref.setIsLoggedIn(model.success);
                appStoragePref.setCustomerToken(model.customerToken);
                appStoragePref.setQuoteId(0);
                appStoragePref.setUserData(UserDataModel(
                    cartCount: model.cartCount,
                    name: model.customerName,
                    email: model.customerEmail,
                    bannerImage: model.bannerImage,
                    profileImage: model.profileImage));
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.bottomTabBar, (route) => false);
              });
                print("--->===>${state.data.customerToken}");
            } else if (state is LoadingState) {
              _loading = true;
            } else if (state is SigninSignupScreenError) {
              _loading = false;
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showWarning(state.message ?? "", context);
              });
              bloc?.emit(SignupScreenEmpty());
            }
            return _buildUI();
          }),
        ),
      ),
    );
  }

  Widget _buildUI() {
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   if(widget.isFromCartForLogin){
    //     _openBottomModalSheet(ModalType.signin);
    //   }
    //
    //   if(widget.isFromCartForSignup){
    //     _openBottomModalSheet(ModalType.createAccount);
    //   }
    // });
    return Stack(
      children: <Widget>[
        Column(
          children: [
            Expanded(child: Image.asset(
              AppImages.signinSignupTopIcon,
              fit: BoxFit.fill,
            )),
            Expanded(
                child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  Utils.getStringValue(context, AppStringConstant.get_grocery_wanik), // appName
                  //style: Theme.of(context).textTheme.displayLarge,
                  style: const TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            )),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: AppSizes.spacingTiny),
              child: Text(
                Utils.getStringValue(context, AppStringConstant.signInRegister),
                /*style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontSize: AppSizes.paddingMedium),*/
                style: const TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 15,),
            /*appOutlinedButton(context, () {
              signInSignUpBottomModalSheet(context, false, false);
            },*/
            appRoundcornerButton(context,(){
               signInSignUpBottomModalSheet(context, false, false);
                },
                Utils.getStringValue(
                    context, AppStringConstant.signInWithEmail), backgroundColor: Color(0xFF4285F4),),
            const SizedBox(height: AppSizes.paddingMedium),

            appRoundcornerButton(context, () {
              signInSignUpBottomModalSheet(context, true, false);
            },
                Utils.getStringValue(
                    context, AppStringConstant.createAnAccount),backgroundColor: Color(0xFF4A66AC)),
            const SizedBox(height: AppSizes.spacingLarge),
          ],
        ),
        Visibility(
          visible: _loading,
          child: const Loader(),
        ),
      ],
    );
  }
}
