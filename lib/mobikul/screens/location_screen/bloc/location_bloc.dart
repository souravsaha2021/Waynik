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
import 'package:test_new/mobikul/screens/location_screen/bloc/location_state.dart';

import 'location_event.dart';
import 'location_repository.dart';

class LocationScreenBloc extends Bloc<LocationScreenEvent, LocationScreenState>{
  LocationRepositoryImp? repository;
  LocationScreenBloc({this.repository}):super(LocationScreenInitialState()){
    on<LocationScreenEvent>(mapEventToState);
  }

  @override
  void mapEventToState(
      LocationScreenEvent event, Emitter<LocationScreenState> emit) async {
    if(event is SearchPlaceEvent){
      emit(LocationScreenLoadingState());
      try {
        var model = await repository?.getPlace(event.query);
        if (model != null) {
          emit( SearchPlaceSuccessState(model));
        } else {
          emit(SearchPlaceErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(SearchPlaceErrorState(error.toString()));
      }
    }
    else if(event is SearchPlaceInitialEvent){
      emit(LocationScreenInitialState());
    }
  }
}