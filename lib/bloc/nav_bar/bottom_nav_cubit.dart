import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:untitled1/page/user/search_product.dart';
import 'bottom_van_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(BottomNavBarInitialState());

  static BottomNavBarCubit get(context) => BlocProvider.of(context);

  initialState(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((event) {
      AwesomeDialog(
              context: context,
              title: 'title',
              body: Text("${event.notification?.body}"))
          .show();
    });

    var message = await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {}
  }

  void navigate(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SearchProduct()));
    });
  }

  int currentIndex = 0;

  void changeBottomNavBar(index) {
    currentIndex = index;
    emit(BottomNavBar());
  }
}
