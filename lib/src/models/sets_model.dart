import 'package:vockify/src/models/set_model.dart';

class SetsModel {
  final List<int> ids;
  final Map<int, SetModel> sets;

  SetsModel({
    required this.ids,
    required this.sets,
  });

  SetsModel copyWith({
    List<int>? ids,
    Map<int, SetModel>? sets,
  }) {
    return SetsModel(
      ids: ids ?? this.ids,
      sets: sets ?? this.sets,
    );
  }
}
