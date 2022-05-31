import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/news_app/search/search_screen.dart';
import '../../shared/componants/componant.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <NewsCubit,NewsStates> (
      listener: (context,state){},
      builder: (context,state){

        var cubit = NewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
                'News App'
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreenForNewsApp());
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                  onPressed: (){
                    NewsCubit.get(context).changeAppMode();
                  },
                  icon: Icon(Icons.dark_mode_outlined)),
            ],
          ),
          body: cubit.Screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(

            currentIndex: cubit.currentIndex,

            onTap: (index){
              cubit.changeBottomNavBar(index);
            },

            items : cubit.BottomItem,
          ),
        );
      },
    ) ;
  }
}
