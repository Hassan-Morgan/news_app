import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassan_beh/cubit/cubit.dart';
import 'package:hassan_beh/cubit/states.dart';
import 'package:hassan_beh/shared/components/components.dart';
import 'package:hassan_beh/shared/constants/constants.dart';

class SavedNews extends StatelessWidget {
  const SavedNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('SAVED NEWS'),
          actions: [
            defaultThemChangerIcon(context: context),
          ],
        ),
        body: defaultNewsViewer(
          state: state,
          context: context,
          list: savedItems,
        ),
      ),
      );
  }
}
