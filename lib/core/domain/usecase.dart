import 'package:equatable/equatable.dart';

// T is the return type, P is the parameter type
abstract class UseCase<T, P> {
  Future<T> call(P params);
}

class NoParams extends Equatable {
  const NoParams();
  @override
  List<Object?> get props => [];
}
