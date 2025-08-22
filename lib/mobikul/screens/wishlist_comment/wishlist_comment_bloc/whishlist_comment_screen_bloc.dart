

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

import 'package:flutter_bloc/flutter_bloc.dart';

import 'wishlist_comment_screen_event.dart';
import 'wishlist_comment_screen_repository.dart';
import 'wishlist_comment_screen_state.dart';


class WishlistCommentScreenBloc extends Bloc<WishlistCommentScreenEvent, WishlistCommentScreenState> {
  WishlistCommentScreenRepository? repository;

  WishlistCommentScreenBloc({this.repository}) : super(WishlistCommentScreenInitialState()) {
    on<WishlistCommentScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      WishlistCommentScreenEvent event,
      Emitter<WishlistCommentScreenState> emit,
      ) async {

  }
}