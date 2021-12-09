import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassan_beh/cubit/states.dart';
import 'package:hassan_beh/shared/constants/constants.dart';
import 'package:hassan_beh/shared/network/local/cash_helper.dart';
import 'package:hassan_beh/shared/network/remot/dio_helper.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  var database;

  int bottomNavigationBarIndex = 0;

  ThemeMode appTheme = ThemeMode.light;
  bool isAppLight = true;
  Icon modeIcon = const Icon(Icons.dark_mode_sharp);

  void changeBottomNavigationIndex(index) {
    bottomNavigationBarIndex = index;
    emit(ChangeBottomNavigationBar());
  }

  void getDataFromDio() {
    emit(LoadingData());
    DioHelper.getData(path: 'v2/top-headlines', queryParameters: {
      'country': 'eg',
      'category': 'general',
      'apiKey': apiKey,
      'fbclid': 'IwAR27FnVbV9ESooo7TAWH5r-MoNQ6h1jrfUUPBTi84Oo4HRq60kY2hDajke8',
    }).then((value) {
      general = value.data["articles"];
      emit(GetDataSuccess());
    }).catchError((onError) {
      emit(GetDataError(onError.toString()));
    });

    DioHelper.getData(path: 'v2/top-headlines', queryParameters: {
      'country': 'eg',
      'category': 'business',
      'apiKey': apiKey,
      'fbclid': 'IwAR27FnVbV9ESooo7TAWH5r-MoNQ6h1jrfUUPBTi84Oo4HRq60kY2hDajke8',
    }).then((value) {
      business = value.data['articles'];
      emit(GetDataSuccess());
    }).catchError((onError) {
      emit(GetDataError(onError.toString()));
    });

    DioHelper.getData(path: 'v2/top-headlines', queryParameters: {
      'country': 'eg',
      'category': 'entertainment',
      'apiKey':apiKey,
      'fbclid': 'IwAR27FnVbV9ESooo7TAWH5r-MoNQ6h1jrfUUPBTi84Oo4HRq60kY2hDajke8',
    }).then((value) {
      entertainment = value.data['articles'];
      emit(GetDataSuccess());
    }).catchError((onError) {
      emit(GetDataError(onError.toString()));
    });

    DioHelper.getData(path: 'v2/top-headlines', queryParameters: {
      'country': 'eg',
      'category': 'health',
      'apiKey': apiKey,
      'fbclid': 'IwAR27FnVbV9ESooo7TAWH5r-MoNQ6h1jrfUUPBTi84Oo4HRq60kY2hDajke8',
    }).then((value) {
      health = value.data['articles'];
      emit(GetDataSuccess());
    }).catchError((onError) {
      emit(GetDataError(onError.toString()));
    });

    DioHelper.getData(path: 'v2/top-headlines', queryParameters: {
      'country': 'eg',
      'category': 'science',
      'apiKey': apiKey,
      'fbclid': 'IwAR27FnVbV9ESooo7TAWH5r-MoNQ6h1jrfUUPBTi84Oo4HRq60kY2hDajke8',
    }).then((value) {
      science = value.data['articles'];
      emit(GetDataSuccess());
    }).catchError((onError) {
      emit(GetDataError(onError.toString()));
    });

    DioHelper.getData(path: 'v2/top-headlines', queryParameters: {
      'country': 'eg',
      'category': 'sports',
      'apiKey': apiKey,
      'fbclid': 'IwAR27FnVbV9ESooo7TAWH5r-MoNQ6h1jrfUUPBTi84Oo4HRq60kY2hDajke8',
    }).then((value) {
      sports = value.data['articles'];
      emit(GetDataSuccess());
    }).catchError((onError) {
      emit(GetDataError(onError.toString()));
    });

    DioHelper.getData(path: 'v2/top-headlines', queryParameters: {
      'country': 'eg',
      'category': 'technology',
      'apiKey': apiKey,
      'fbclid': 'IwAR27FnVbV9ESooo7TAWH5r-MoNQ6h1jrfUUPBTi84Oo4HRq60kY2hDajke8',
    }).then((value) {
      technology = value.data['articles'];
      emit(GetDataSuccess());
    }).catchError((onError) {
      emit(GetDataError(onError.toString()));
    });
  }

  void getSearchData({value}) {
    emit(LoadingData());
    DioHelper.getData(path: 'v2/everything', queryParameters: {
      'q': '$value',
      'apiKey': apiKey,
      'fbclid': 'IwAR27FnVbV9ESooo7TAWH5r-MoNQ6h1jrfUUPBTi84Oo4HRq60kY2hDajke8',
    }).then((value) {
      searchResults = value.data["articles"];
      emit(GetDataSuccess());
    }).catchError((onError) {
      emit(GetDataError(onError.toString()));
    });
  }

  void changeAppTheme() {
    if (isAppLight == true) {
      appTheme = ThemeMode.dark;
      modeIcon = const Icon(Icons.light_mode_sharp);
      CashHelper.putData(isDark: true);
      isAppLight = false;
    } else {
      appTheme = ThemeMode.light;
      CashHelper.putData(isDark: false);
      modeIcon = const Icon(Icons.dark_mode_sharp);
      isAppLight = true;
    }
    if (state is GetDataError || state is LoadingData) {
      emit(ChangeAppTheme());
      getDataFromDio();
    } else {
      emit(ChangeAppTheme());
    }
  }

  void defaultAppThem(bool? isDark){
    bool? x = isDark;
    if (x==null){
    appTheme = ThemeMode.light;
    }else if(x==true){
      appTheme = ThemeMode.dark;
      isAppLight = false;
      modeIcon= const Icon(Icons.light_mode_sharp);
    }else{
      appTheme = ThemeMode.light;
    }
  }

  void openDataBase() async {
    database = await openDatabase('savedData.db', version: 1,
        onCreate: (database, version) {
          database
              .execute(
              'CREATE TABLE savedItems (id INTEGER PRIMARY KEY, title TEXT, time TEXT, urlToImage TEXT,url TEXT)')
              .then((value) {
          });
        },
        onOpen: (database) {
          getDataFromDatabase(database).then((value) {getDataFromDio();});
        });
  }

  void insertIntoDatabase({
    required String title,
    required String time,
    required String urlToImage,
    required String url,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
          'INSERT INTO savedItems (title, time, urlToImage,url) VALUES("$title","$time","$urlToImage","$url")')
          .then((value) {
        getDataFromDatabase(database);
      });
    });
  }

  Future<void> getDataFromDatabase(database)  {return
    database.rawQuery('SELECT * FROM savedItems').then((value) {
      savedItems = value;
      emit(GetDataFromDatabase());
    });
  }

  void deleteFromDatabase({required int id}) async {
    await database
        .rawDelete('DELETE FROM savedItems WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
    });
  }
}
