import 'package:equatable/equatable.dart';

final class GenreEntity extends Equatable {
  final int id;
  final String name;

  const GenreEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
