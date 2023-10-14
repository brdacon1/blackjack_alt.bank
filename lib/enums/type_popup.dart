import 'package:collection/collection.dart';

enum TypePopupEnum {
  ERROR(0, 'Aguardando captura...'),
  CONGRATULATIONS(1, 'Parabéns você venceu!'),
  WAIT(2, 'Aguarde...'),
  LOSE(3, 'Você perdeu!'),
  TIED(4, 'Jogo empatado!');

  final int value;
  final String description;
  const TypePopupEnum(this.value, this.description);

  static TypePopupEnum? typePopupEumFromValue(int? value) {
    return TypePopupEnum.values.firstWhereOrNull((s) => s.value == value);
  }
}
