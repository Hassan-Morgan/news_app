import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassan_beh/cubit/cubit.dart';
import 'package:hassan_beh/cubit/states.dart';
import 'package:hassan_beh/shared/components/components.dart';
import 'package:hassan_beh/shared/constants/constants.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('SEARCH'),
          actions: [
            defaultThemChangerIcon(context: context),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor)),
                    focusedBorder:  OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        borderSide:
                        BorderSide(color: defaultAppColor)),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                    ),
                    hintText: 'Write to Search',
                    hintStyle: Theme.of(context).textTheme.bodyText2
                  ),
                  style: Theme.of(context).textTheme.bodyText1,
                  onChanged: (String value){
                    AppCubit.get(context).getSearchData(
                      value:value
                    );
                  },
                  onSaved: (value){
                    AppCubit.get(context).getSearchData(
                        value:value
                    );
                  },
                ),
                const SizedBox(height: 20,),
                defaultNewsViewer(state: state, list: searchResults, context: context,physics: const NeverScrollableScrollPhysics()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
