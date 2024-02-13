import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_flutter/bloc/Home/home_bloc.dart';
import 'package:task_flutter/bloc/Home/home_event.dart';
import 'package:task_flutter/bloc/Home/home_state.dart';
import 'package:task_flutter/helper/dismissKeyboard.dart';
import 'package:task_flutter/repository/HomeRepo/homeApi.dart';
import 'package:task_flutter/utils/themeColor.dart';
import 'package:http/http.dart' as http;
import 'package:task_flutter/widget/Home/dividerHobber.dart';
import 'package:task_flutter/widget/Home/dropdownWidget.dart';
import 'package:task_flutter/widget/Home/textField.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  late HomeBloc homeBloc;

  HomeApi homeApi = HomeApi(httpClient: http.Client());

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? titleErrorText;

  List<String> assignedTo = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeBloc = HomeBloc(homeApi: homeApi);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Scaffold(
        backgroundColor: ColorsFave.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          title: const Text('Add Task'),
          centerTitle: true,
          backgroundColor: ColorsFave.primaryColor,
        ),
        body: BlocListener(
            bloc: homeBloc,
            listener: (context, state) {
              if (state is AddItemSuccess) {
                Navigator.pop(context, true);
              } else if (state is AddItemFailure) {
                Fluttertoast.showToast(msg: state.message!);
              }
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Title',
                                style: TextStyle(
                                    color: ColorsFave.primaryColor,
                                    fontSize: 12)),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              child: TextFieldWidget(
                                  controller: titleController,
                                  errorTitle: 'Enter title please!',
                                  hintTitle: 'Title'),
                            ),
                            const DividerWidget(),
                            Text('Description',
                                style: TextStyle(
                                    color: ColorsFave.primaryColor,
                                    fontSize: 12)),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              child: TextFieldWidget(
                                  controller: descriptionController,
                                  errorTitle: 'Enter description please!',
                                  hintTitle: 'Description'),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: MultiSelectDropdownScreen(
                                  assignedTo: (callBackAssignedTo) {
                                assignedTo = callBackAssignedTo;
                              }),
                            )
                          ],
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocBuilder(
                          bloc: homeBloc,
                          builder: (context, state) {
                            if (state is AddItemInProgress) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            return Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorsFave.primaryColor,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate() &&
                                      assignedTo.isNotEmpty) {
                                    homeBloc.add(AddItemRequested(
                                      title: titleController.text,
                                      assignedTo: assignedTo,
                                      description: descriptionController.text,
                                    ));
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'Complete all data please!');
                                  }
                                },
                                child: const Text(
                                  'Add Task',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
