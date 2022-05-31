import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/news-layout/NewsLayout.dart';
import '../../../layout/news-layout/cubit/cubit.dart';
import '../../../layout/news-layout/cubit/states.dart';
import '../../../shared/componants/componant.dart';

class SearchScreenForNewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context , state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(icon:Icon(Icons.arrow_back_ios_outlined),onPressed: (){
              navigateToAndReplace(context, NewsLayout());
            }),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: defaultTextFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    onChange: (value){
                      NewsCubit.get(context).getSearch(value);
                    },
                    validate: (String? value)
                    {
                      if(value!.isEmpty){
                        return 'search must not be empty' ;
                      }
                    },
                    label: 'search',
                    prefix: Icons.search
                ),
              ),
              Expanded(child: articleBuilder(list, context, isSearch : true) )
            ],
          ),
        );
      },
    );
  }
}
