import 'package:equatable/equatable.dart';

class MainState extends Equatable {
  final MainState mainState;

  const MainState._({
    required this.mainState,
});



  @override
  List<Object?> get props => [mainState];

}