import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app/layout/news-layout/cubit/states.dart';

import '../../../modules/news_app/business/business_screen.dart';
import '../../../modules/news_app/sience/sience_screen.dart';
import '../../../modules/news_app/sports/sports_screen.dart';
import '../../../shared/network/local/cashe_helper.dart';
import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit <NewsStates>
{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context) ;

  int currentIndex = 0 ;

  List<BottomNavigationBarItem> BottomItem =
  [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.add_business
      ),
      label: 'Business'
    ),
    BottomNavigationBarItem(
        icon: Icon(
            Icons.sports
        ),
        label: 'Sport'
    ),
    BottomNavigationBarItem(
        icon: Icon(
            Icons.science
        ),
        label: 'Science'
    ),
    /*BottomNavigationBarItem(
        icon: Icon(
            Icons.settings
        ),
        label: 'Settings'
    ),*/
  ];

  List<Widget> Screens = [
    BusinessScreen(),
    SportsScreen(),
    SienceScreen(),
    //SettingsScreen(),
  ];

  void changeBottomNavBar (int index)
  {
    if(index == 1) {
      getSports() ;
    }
    else if (index == 2 ){
      getScience();
    }
    currentIndex = index ;
    emit(ChangeBottomNavBarState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingStates());

    if(business.length == 0 ){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query:{
            'country':'eg',
            'category':'business',
            'apiKey':'65f7f556ec76449fa7dc7c0069f040ca'
          }
      ).then((value) {

        business = value.data['articles'];
        print(business[0]['title']);
        emit(NewsGetBusinessSuccessData());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetBusinessErrorData(error.toString()));
      });
    }
    else {
      emit(NewsGetBusinessSuccessData());
    };


  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingStates());

    if(sports.length == 0 ){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query:{
            'country':'eg',
            'category':'sports',
            'apiKey':'65f7f556ec76449fa7dc7c0069f040ca'
          }
      ).then((value) {

        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessData());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorData(error.toString()));
      });
    }
    else {
      emit(NewsGetSportsSuccessData());
    }


  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingStates());

    if(science.length == 0 ){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query:{
            'country':'eg',
            'category':'science',
            'apiKey':'65f7f556ec76449fa7dc7c0069f040ca'
          }
      ).then((value) {

        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessData());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorData(error.toString()));
      });
    }
    else{
      emit(NewsGetScienceSuccessData());
    }


  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetBusinessLoadingStates());

    DioHelper.getData(
        url: 'v2/everything',
        query:{

          'q':'$value',
          'apiKey':'65f7f556ec76449fa7dc7c0069f040ca'
        }
    ).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessData()
      );
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorData(error.toString()));
    });
  }
  bool isDark = false ;

  void changeAppMode(){

    /*if (fromShared != null){
      isDark = fromShared;
      emit(AppChangeModeState());
    }
    else {*/
    isDark = !isDark;
    CasheHelper.putBoolean(key: 'isDark', value: isDark).then((value){
      emit(AppChangeModeState());
    });
  }
}