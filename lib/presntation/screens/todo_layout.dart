import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../bussiness_logic/cubit/cubit.dart';
import '../../bussiness_logic/cubit/states.dart';
import '../../core/global/global_methods.dart';


class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  void dispose() {
    timeController.dispose();
    timeController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
        if (state is AppInsertDataBaseState) {
          Navigator.pop(context);
        }
      }, builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Center(
              child: Text(
                cubit.titles[cubit.currentIndex],
              ),
            ),
          ),
          body: ConditionalBuilder(
            condition: state is! AppGetDataBaseLoadingState,
            builder: (context) => cubit.screens[cubit.currentIndex],
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepOrange,
            onPressed: () {
              if (cubit.isBottomSheetShown) {
                if (formKey.currentState!.validate()) {
                  cubit.insertToDatabase(
                    title: titleController.text,
                    date: dateController.text,
                    time: timeController.text,
                  );
                  titleController.clear();
                  dateController.clear();
                  timeController.clear();
                  cubit.isBottomSheetShown == false;
                }
              } else {
                scaffoldKey.currentState
                    ?.showBottomSheet(
                      (context) => Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultFormFailed(
                                controller: titleController,
                                type: TextInputType.text,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'title must not be empty';
                                  }
                                },
                                label: 'Task Title',
                                prefix: Icons.title,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              defaultFormFailed(
                                controller: timeController,
                                type: TextInputType.datetime,
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder: (context, child) => Theme(
                                      data: ThemeData().copyWith(
                                          colorScheme: const ColorScheme.dark(
                                            primary: Colors.blueAccent,
                                            onPrimary: Colors.white,
                                            surface: Colors.white,
                                            onSurface: Colors.green,
                                          ),
                                          dialogBackgroundColor: Colors.black),
                                      child: child!,
                                    ),
                                  ).then((value) {
                                    timeController.text =
                                        value!.format(context).toString();
                                  });
                                },
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'time must not be empty';
                                  }
                                },
                                label: 'Task Time',
                                prefix: Icons.watch_later_outlined,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              defaultFormFailed(
                                controller: dateController,
                                type: TextInputType.datetime,
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2030-12-01'),
                                    builder: (context, child) => Theme(
                                      data: ThemeData().copyWith(
                                        colorScheme: const ColorScheme.dark(
                                          primary: Colors.blueAccent,
                                          onPrimary: Colors.white,
                                          surface: Colors.white,
                                          onSurface: Colors.green,
                                        ),
                                        dialogBackgroundColor: Colors.white,
                                      ),
                                      child: child!,
                                    ),
                                  ).then((value) {
                                    dateController.text = DateFormat.yMMMd()
                                        .format(value!)
                                        .toString();
                                  });
                                },
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'date must not be empty';
                                  }
                                  return null;
                                },
                                label: 'Task Date',
                                prefix: Icons.calendar_today_outlined,
                              ),
                            ],
                          ),
                        ),
                      ),
                      elevation: 20.0,
                    )
                    .closed
                    .then((value) {
                  cubit.changeBottomSheetState(
                    isShow: false,
                    icon: Icons.edit,
                  );
                });
                cubit.changeBottomSheetState(
                  isShow: true,
                  icon: Icons.add,
                );
              }
            },
            child: Icon(
              cubit.fabIcon,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 20.0,
            backgroundColor: Colors.white,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu,
                ),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.check_circle_outline,
                ),
                label: 'Done',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.archive_outlined,
                ),
                label: 'Archived',
              ),
            ],
          ),
        );
      }),
    );
  }
}
