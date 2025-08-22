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
import 'package:test_new/mobikul/screens/review_details/block/review_details_screen_events.dart';
import 'package:test_new/mobikul/screens/review_details/block/review_details_screen_repository.dart';
import 'package:test_new/mobikul/screens/review_details/block/review_details_screen_state.dart';
import 'package:test_new/mobikul/screens/reviews/block/reviews_screen_events.dart';
import 'package:test_new/mobikul/screens/reviews/block/reviews_screen_repository.dart';
import 'package:test_new/mobikul/screens/reviews/block/reviews_screen_state.dart';

class ReviewDetailsScreenBloc extends Bloc<ReviewDetailsScreenEvent, ReviewDetailsScreenState> {
  ReviewDetailsScreenRepositoryImp? repository;

  ReviewDetailsScreenBloc({this.repository}) : super(ReviewDetailsScreenInitial()) {
    on<ReviewDetailsScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      ReviewDetailsScreenEvent event, Emitter<ReviewDetailsScreenState> emit) async {
    if (event is ReviewDetailsScreenDataFetchEvent) {
      emit(ReviewDetailsScreenInitial());
      try {
        var model = await repository?.getReviewDetails(event.id);
        if (model != null) {
          emit(ReviewDetailsScreenSuccess(model));
        } else {
          emit(const ReviewDetailsScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(ReviewDetailsScreenError(error.toString()));
      }
    }
  }
}
