import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassan_beh/cubit/cubit.dart';
import 'package:hassan_beh/cubit/states.dart';
import 'package:hassan_beh/shared/components/components.dart';
import 'package:hassan_beh/shared/constants/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => DefaultTabController(
        length: 7,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('NEWS APP'),
            actions: [
              defaultThemChangerIcon(context: context),
            ],
            bottom: TabBar(
              tabs: const [
                Tab(
                  child: Text('GENERAL'),
                ),
                Tab(
                  child: Text('BUSINESS'),
                ),
                Tab(
                  child: Text('ENTERTAINMENT'),
                ),
                Tab(
                  child: Text('HEALTH'),
                ),
                Tab(
                  child: Text('SCIENCE'),
                ),
                Tab(
                  child: Text('SPORTS'),
                ),
                Tab(
                  child: Text('TECHNOLOGY'),
                ),
              ],
              indicatorColor: defaultAppColor,
              isScrollable: true,
            ),
          ),
          body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                defaultNewsViewer(
                    list: general, context: context, state: state),
                defaultNewsViewer(
                    list: business, context: context, state: state),
                defaultNewsViewer(
                    list: entertainment, context: context, state: state),
                defaultNewsViewer(list: health, context: context, state: state),
                defaultNewsViewer(
                    list: science, context: context, state: state),
                defaultNewsViewer(list: sports, context: context, state: state),
                defaultNewsViewer(
                    list: technology, context: context, state: state),
              ]),
        ),
      ),
    );
  }
}
