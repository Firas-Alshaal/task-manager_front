import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:task_flutter/bloc/Home/home_bloc.dart';
import 'package:task_flutter/bloc/Home/home_event.dart';
import 'package:task_flutter/bloc/Home/home_state.dart';
import 'package:task_flutter/general/NotFondPage.dart';
import 'package:task_flutter/general/NotFondProduct.dart';
import 'package:task_flutter/helper/dismissKeyboard.dart';
import 'package:task_flutter/model/Home/home.dart';
import 'package:task_flutter/repository/HomeRepo/homeApi.dart';
import 'package:task_flutter/screen/AddItem.dart';
import 'package:task_flutter/utils/themeColor.dart';
import 'package:task_flutter/widget/Home/loadingWidget.dart';
import 'package:task_flutter/widget/Home/productItem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc homeBloc;
  HomeApi homeApi = HomeApi(httpClient: http.Client());

  late List<Task> items;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeBloc = HomeBloc(homeApi: homeApi);
    homeBloc.add(GetItemsRequested());
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    homeBloc.add(GetItemsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Scaffold(
          backgroundColor: ColorsFave.backgroundColor,
          appBar: AppBar(
            elevation: 0,
            title: const Text('Tasks'),
            centerTitle: true,
            backgroundColor: ColorsFave.primaryColor,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const AddItem()))
                .then((value) =>
                    value != null ? homeBloc.add(GetItemsRequested()) : () {}),
            backgroundColor: ColorsFave.primaryColor,
            child: const Icon(Icons.add),
          ),
          body: Column(
            children: [
              Expanded(
                child: BlocBuilder(
                  bloc: homeBloc,
                  builder: (context, state) {
                    if (state is GetItemsInProgress) {
                      return const LottieWidget();
                    } else if (state is GetItemsSuccess) {
                      items = state.items;
                      return items.isEmpty
                          ? Center(child: NotFoundPrduct(
                              pres: () {
                                homeBloc.add(GetItemsRequested());
                              },
                            ))
                          : RefreshIndicator(
                              onRefresh: _pullRefresh,
                              color: ColorsFave.primaryColor,
                              child: ListView(
                                children: [
                                  Column(
                                    children: items
                                        .map((item) => TaskItem(item: item))
                                        .toList(),
                                  ),
                                ],
                              ),
                            );
                    } else if (state is GetItemsFailure) {
                      return NotFoundPage(
                        onPressed: () {
                          homeBloc.add(GetItemsRequested());
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          )),
    );
  }
}
