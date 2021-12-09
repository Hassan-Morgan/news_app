import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassan_beh/cubit/states.dart';
import 'package:hassan_beh/lay_out/lay_out.dart';
import 'package:hassan_beh/shared/constants/constants.dart';
import 'package:hassan_beh/shared/network/local/cash_helper.dart';
import 'package:hassan_beh/shared/network/remot/dio_helper.dart';

import 'cubit/bloc_observer.dart';
import 'cubit/cubit.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CashHelper.init();
  Bloc.observer = MyBlocObserver();
  bool? isDark = CashHelper.getData();
  runApp( MyApp( isDark:isDark));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key,this.isDark}) : super(key: key);

  final bool? isDark;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context )=> AppCubit()..openDataBase()..getDataFromDio()..defaultAppThem(isDark),
    child: BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state)=>MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App',
        theme: ThemeData(

            primaryColor: Colors.black,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              selectedItemColor: defaultAppColor,
              selectedLabelStyle: const TextStyle(
                  fontSize: 11
              ),

            ),
            appBarTheme:AppBarTheme(
              iconTheme:  IconThemeData(color: defaultAppColor),
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              backgroundColor: Colors.white,
              titleTextStyle:  TextStyle(
                color: defaultAppColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            tabBarTheme: TabBarTheme(
              labelColor: defaultAppColor,
              unselectedLabelColor: Colors.black,
            ),
            scaffoldBackgroundColor: Colors.white,
            textTheme:  TextTheme(
                bodyText1: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                bodyText2: TextStyle(
                  color: Colors.grey[400],
              ),
            )
        ),
        darkTheme:ThemeData(
            primaryColor: Colors.white,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.black,
              selectedItemColor: defaultAppColor,
              selectedLabelStyle: const TextStyle(
                  fontSize: 11
              ),
              unselectedItemColor: Colors.white,

            ),
            appBarTheme:AppBarTheme(
              iconTheme: IconThemeData(color: defaultAppColor),
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor:Colors.black45,
                statusBarIconBrightness: Brightness.light,
              ),
              backgroundColor: Colors.black54,
              titleTextStyle:  TextStyle(
                color: defaultAppColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            tabBarTheme: TabBarTheme(
              labelColor: defaultAppColor,
              unselectedLabelColor: Colors.white,
            ),
            scaffoldBackgroundColor: Colors.black54,
            textTheme:  TextTheme(
                bodyText1: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              bodyText2: TextStyle(
                color: Colors.grey[600],
              ),
            )
        ),
        themeMode:AppCubit.get(context).appTheme,
        home:AppScreen(),
      ),
    ),
    );
  }
}

