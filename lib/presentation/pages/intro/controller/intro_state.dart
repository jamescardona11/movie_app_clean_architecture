import 'package:equatable/equatable.dart';

class IntroState extends Equatable {
  final bool isLoading;

  const IntroState({
    this.isLoading = true,
  });

  @override
  List<Object?> get props => [
        isLoading,
      ];

  IntroState copyWith({
    bool? isLoading,
  }) {
    return IntroState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
