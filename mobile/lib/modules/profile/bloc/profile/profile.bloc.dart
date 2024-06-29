import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/data/models/user.model.dart';
import 'package:mobile/data/repositories/user.repository.dart';

part 'profile.event.dart';
part 'profile.state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;

  ProfileBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const ProfileState()) {
    on<ProfileEventStarted>(_onStartedGetProfile);
    add(const ProfileEventStarted());
  }

  Future<void> _onStartedGetProfile(
    ProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        status: HandleStatus.loading,
      ),
    );

    final user = await _userRepository.getUserProfile();

    emit(
      state.copyWith(
        status: HandleStatus.success,
        user: user,
      ),
    );
  }
}
