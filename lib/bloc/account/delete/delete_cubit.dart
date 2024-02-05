import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../network/remote/http.dart';
import 'delete_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit() : super(InitialState());

  static DeleteAccountCubit get(context) => BlocProvider.of(context);

  Future deleteAccount() async {
    emit(DeleteLoadingState());
    await HttpHelper.deleteData(url: 'deleteAccount').then((value) {
      if (value.statusCode == 200) {
        emit(DeleteSuccessState());
      }
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(DeleteErrorState());
    });
  }
}
