import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassan_beh/cubit/cubit.dart';
import 'package:hassan_beh/cubit/states.dart';
import 'package:hassan_beh/modules/home_page/home_page.dart';
import 'package:hassan_beh/modules/saved_news/saved_news.dart';
import 'package:hassan_beh/modules/search/search.dart';

class AppScreen extends StatelessWidget {
  AppScreen({Key? key}) : super(key: key);

  List<Widget> appScreens = [
    const HomePage(),
    const Search(),
    const SavedNews(),

  ];

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state) {
          AppCubit cubit = AppCubit.get(context);
              return Scaffold(
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: cubit.bottomNavigationBarIndex,
                  onTap: (index){cubit.changeBottomNavigationIndex(index);},
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'HOME'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.search), label: 'SEARCH'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.save), label: 'SAVED'),
                  ],
                ),
                body: appScreens[cubit.bottomNavigationBarIndex],
              );
        },
    );
  }
}
