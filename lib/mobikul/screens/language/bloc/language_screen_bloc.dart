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

import 'language_screen_event.dart';
import 'language_screen_repository.dart';
import 'language_screen_state.dart';

class LanguageScreenBloc extends Bloc<LanguageEvent, LanguageScreenState>{
  LanguageRepositoryImp? repository;

  LanguageScreenBloc({this.repository}) : super(LanguageInitialState()) {
    on<LanguageEvent>(mapEventToState);
  }

  void mapEventToState(
      LanguageEvent event, Emitter<LanguageScreenState> emit) async {
    if (event is LanguageSaveEvent) {
      emit(LanguageLoadingState());
     /* try {
        var model = await repository?.getLanguageList();
        if (model != null) {
          emit(LanguageSuccessState(model));
        } else {
          emit(const LanguageErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(LanguageErrorState(error.toString()));
      }*/
    }
  }
}