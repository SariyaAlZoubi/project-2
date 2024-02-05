import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../network/remote/http.dart';
import 'logout_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit() : super(LogOutInitialState());

  static LogOutCubit get(context) => BlocProvider.of(context);

  Future logout() async {
    emit(LogOutLoadingState());
    await HttpHelper.deleteData(url: 'logout').then((value) {
      if (value.statusCode == 200) {
        emit(LogOutSuccessState());
      }
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(LogOutErrorState());
    });
  }
}
