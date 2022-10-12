import 'package:bloc/bloc.dart';
import 'package:ecommerce_clean/app/app_data.dart';
import 'package:ecommerce_clean/app/app_repository.dart';
import 'package:equatable/equatable.dart';

part 'bloc_main_state.dart';

class BlocMainCubit extends Cubit<BlocMainState> {
  BlocMainCubit({required this.repository}) : super(BlocMainInitial()) {
    _appData = repository.loadAppData();
  }
  final AppRepository repository;
  AppData? _appData;
  AppState get appState {
    // print(_appData!.isVerfied);
    // print(_appData!.isCompleted);

    if (_appData == null || _appData!.isSeenTutorial != true)
      // ignore: curly_braces_in_flow_control_structures
      return AppState.notSeenTutorial;
    if (_appData!.isGuestUser == null ||
        _appData!.isGuestUser != null && _appData!.isGuestUser == true)
      // ignore: curly_braces_in_flow_control_structures
      return AppState.guest;

    if (_appData != null && (_appData!.id == null || _appData!.id!.isEmpty))
      // ignore: curly_braces_in_flow_control_structures
      return AppState.unauthenticated;
    if (_appData!.isVerfied == false)
      // ignore: curly_braces_in_flow_control_structures
      return AppState.notVerified;
    // if (_appData!.isCompleted == false)
    //   // ignore: curly_braces_in_flow_control_structures
    //   return AppState.notCompleted;

    // if (_appData.displayName) return AppState.uninitialized;
    return AppState.authenticated;
  }

  void authenticate(
    AppData data,
  ) async {
    _appData = data.copyWith(
        userId: data.id.toString(),
        name: data.displayName,
        phoneCopy: data.phone,
        emailCopy: data.email,
        tokenCopy: data.token,
        isCompleteed: data.isCompleted,
        isvervie: data.isVerfied,
        seenTutorial: data.isSeenTutorial,
        typeUserCopy: data.typeUser,
        langCode: data.languageCode);
    await repository.store.setAppData(_appData!);
    emit(UpdateDataState(appData: _appData!));
  }

  void updateData(
    AppData data,
  ) async {
    _appData = _appData!.copyWith(
        userId: data.id.toString(),
        name: data.displayName,
        phoneCopy: data.phone,
        emailCopy: data.email,
        photo: data.photoUrl,
        // tokenCopy: data.token,
        // typeUserCopy: data.typeUser,
        langCode: data.languageCode);
    await repository.store.setAppData(_appData!);
    emit(UpdateDataState(appData: _appData!));
  }

  void seenIntro() async {
    if (_appData == null) {
      _appData = AppData(isSeenTutorial: true, isGuestUser: true);
    } else {
      _appData = _appData!.copyWith(seenTutorial: true, isGuestUserCopy: true);
    }

    await repository.store.setAppData(_appData!);
    emit(UpdateDataState(appData: _appData!));
  }
}
