import 'package:equatable/equatable.dart';
import 'package:eschool/data/models/parent.dart';
import 'package:eschool/data/models/student.dart';
import 'package:eschool/data/repositories/authRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class UserProfileState extends Equatable {}

class UserProfileInitial extends UserProfileState {
  @override
  List<Object?> get props => [];
}

class UserProfileFetchInProgress extends UserProfileState {
  @override
  List<Object?> get props => [];
}

class UserProfileFetchSuccess extends UserProfileState {
  UserProfileFetchSuccess({required this.wasUserLoggedIn});
  final bool wasUserLoggedIn;
  @override
  List<Object?> get props => [];
}

class UserProfileFetchFailure extends UserProfileState {
  UserProfileFetchFailure(this.errorMessage);
  final String errorMessage;

  @override
  List<Object?> get props => [];
}

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit(this._authRepository) : super(UserProfileInitial());
  final AuthRepository _authRepository;

  Future<void> fetchAndSetUserProfile() async {
    emit(UserProfileFetchInProgress());
    if (_authRepository.getIsLogIn()) {
      try {
        if (_authRepository.getIsStudentLogIn()) {
          final Student? student = await _authRepository.fetchStudentProfile();
          if (student == null) {
            await _authRepository.signOutUser();
          } else {
            await _authRepository.setStudentDetails(student);
          }
        } else {
          final Parent? parent = await _authRepository.fetchParentProfile();
          if (parent == null) {
            await _authRepository.signOutUser();
          } else {
            await _authRepository.setParentDetails(parent);
          }
        }
        emit(UserProfileFetchSuccess(wasUserLoggedIn: true));
      } catch (e) {
        emit(UserProfileFetchFailure(e.toString()));
      }
    } else {
      emit(UserProfileFetchSuccess(wasUserLoggedIn: false));
    }
  }
}
