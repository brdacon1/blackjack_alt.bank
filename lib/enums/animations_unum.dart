import 'package:collection/collection.dart';

enum AnimationsEnum {
  MACHINE_MOBILE(0),
  MACHINE_WEB(1),
  PLAYER_MOBILE(2),
  PLAYER_WEB(3),
  DEFAULT(3);

  final int value;
  const AnimationsEnum(this.value);

  static AnimationsEnum? typePopupEumFromValue(int? value) {
    return AnimationsEnum.values.firstWhereOrNull((s) => s.value == value);
  }
}
