import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hassan_beh/cubit/cubit.dart';
import 'package:hassan_beh/cubit/states.dart';
import 'package:hassan_beh/modules/web_view/web_view.dart';
import 'package:hassan_beh/shared/constants/constants.dart';

Widget defaultNewsViewer({
  ScrollPhysics physics =const BouncingScrollPhysics(),
  required state,
  required List<dynamic> list,
  required BuildContext context,
}) {
  return BlocConsumer<AppCubit,AppStates>(
    listener: (context,state){},
    builder:(context,state)=> BuildCondition(
      condition: state is LoadingData && list != savedItems,
      builder: (context) => Center(
          child: CircularProgressIndicator(
        color: defaultAppColor,
      )),
      fallback: (context) => BuildCondition(
        condition: state is GetDataError && list != savedItems,
        builder: (context) => Center(
          child:
              Text('Unable to load data', style: Theme.of(context).textTheme.bodyText1),
        ),
        fallback: (context) => ListView.separated(
            shrinkWrap: true,
            physics:physics ,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder:(context)=> WebViewer(url: list[index]['url']) ));
                },
                child: Slidable(
                actionPane: const SlidableScrollActionPane(),
                actions: [
                  BuildCondition(
                    condition: list == savedItems,
                    builder:(context)=> IconSlideAction(
                      color: Colors.red,
                      icon: Icons.remove_circle,
                      caption: "REMOVE",
                      onTap: () {
                        AppCubit.get(context).deleteFromDatabase(id: list[index]['id']);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('item removed'),
                              behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 1),
                            ));

                      },
                    ),
                    fallback: (context)=> IconSlideAction(
                      color: Colors.green,
                      icon: Icons.save,
                      caption: "SAVE",
                      onTap: () {
                        try{
                        AppCubit.get(context).insertIntoDatabase(
                          title: list[index]['title'],
                          time: list[index]['publishedAt'],
                          urlToImage: list[index]['urlToImage'],
                          url:list[index]['url'],
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('item saved successfully'),
                            behavior: SnackBarBehavior.floating,
                                duration: Duration(seconds: 1)
                            ));
                        }
                        catch(error){
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('problem happened , cannot save this item'),
                                behavior: SnackBarBehavior.floating,
                                duration: Duration(seconds: 1),
                              ));

                        }
                      },
                    ),
                  ),
                ],
                key: Key(list[index]['title']),
                child: Container(
                  margin: const EdgeInsetsDirectional.only(
                      start: 10, end: 10, top: 10),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(
                              '${list[index]['urlToImage']}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: 120,
                        height: 100,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Column(
                            children: [
                              Text('${list[index]['title']}',
                                  textDirection: TextDirection.rtl,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText1),
                              Row(
                                children: [
                                  Text(
                                    '${list[index]['publishedAt']}',
                                    textDirection: TextDirection.rtl,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyText2,
                                  ),
                                ],
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
            ),
              );
            },
            separatorBuilder: (context, index) => Container(
                  margin: const EdgeInsets.all(20),
                  height: 1,
                  color: Theme.of(context).primaryColor,
                ),
            itemCount: list.length),
      ),
    ),
  );
}

Widget defaultThemChangerIcon({required BuildContext context}){
  return IconButton(
    icon: AppCubit.get(context).modeIcon,
    onPressed: () {
      AppCubit.get(context).changeAppTheme();
    },
    iconSize: 30,
    padding: const EdgeInsets.symmetric(horizontal: 20),
  );
}
