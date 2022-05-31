import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/news-layout/cubit/cubit.dart';
import '../../../layout/news-layout/cubit/states.dart';
import '../../../shared/componants/componant.dart';


class SienceScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state){},
      builder: (context,state){

        var list = NewsCubit.get(context).science;

        return articleBuilder(list,context);
      },
    );
  }
}