part of 'profile_cubit.dart';

class ProfileState {
  final String userName;
  final String userEmail;
  final bool isLoading;

  const ProfileState({
    this.userName = '',
    this.userEmail = '',
    this.isLoading = true,
  });

  ProfileState copyWith({
    String? userName,
    String? userEmail,
    bool? isLoading,
  }) {
    return ProfileState(
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProfileState &&
        other.userName == userName &&
        other.userEmail == userEmail &&
        other.isLoading == isLoading;
  }

  @override
  int get hashCode => userName.hashCode ^ userEmail.hashCode ^ isLoading.hashCode;
}
