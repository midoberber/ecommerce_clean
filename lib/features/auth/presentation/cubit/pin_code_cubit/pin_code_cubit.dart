import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pin_code_state.dart';

class PinCodeCubit extends Cubit<PinCodeState> {
  PinCodeCubit() : super(PinCodeInitial());
}
