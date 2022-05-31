abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class ChangeBottomNavBarState extends NewsStates {}

class NewsGetBusinessLoadingStates extends NewsStates {}

class NewsGetBusinessSuccessData extends NewsStates {}

class NewsGetBusinessErrorData extends NewsStates {

  late final String error;
  NewsGetBusinessErrorData(this.error);

}

class NewsGetSearchLoadingStates extends NewsStates {}

class NewsGetSearchSuccessData extends NewsStates {}

class NewsGetSearchErrorData extends NewsStates {

  late final String error;
  NewsGetSearchErrorData(this.error);

}


class NewsGetSportsLoadingStates extends NewsStates {}

class NewsGetSportsSuccessData extends NewsStates {}

class NewsGetSportsErrorData extends NewsStates {

  late final String error;
  NewsGetSportsErrorData(this.error);

}

class NewsGetScienceLoadingStates extends NewsStates {}

class NewsGetScienceSuccessData extends NewsStates {}

class NewsGetScienceErrorData extends NewsStates {

  late final String error;
  NewsGetScienceErrorData(this.error);

}

class AppChangeModeState extends NewsStates {}

