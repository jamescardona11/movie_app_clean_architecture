import 'package:equatable/equatable.dart';

class IntroState extends Equatable {
  final bool isLoading;
  final bool isFirstTime;

  const IntroState({
    this.isLoading = true,
    this.isFirstTime = true,
  });

  @override
  List<Object?> get props => [
        isLoading,
        isFirstTime,
      ];

  IntroState copyWith({
    bool? isLoading,
    bool? isFirstTime,
  }) {
    return IntroState(
      isLoading: isLoading ?? this.isLoading,
      isFirstTime: isFirstTime ?? this.isFirstTime,
    );
  }
}
