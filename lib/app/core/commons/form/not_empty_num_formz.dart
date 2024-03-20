import 'package:formz/formz.dart';

enum NotEmptyNumError { empty, invalid }

class NotEmptyNumFormz extends FormzInput<String, NotEmptyNumError> {

  const NotEmptyNumFormz.pure() : super.pure('');
  const NotEmptyNumFormz.dirty({String value = ''}) : super.dirty(value);

  static final reg = RegExp(r'^-?\d{1,9}(\.\d{0,2})?$',);

  @override
  NotEmptyNumError? validator(String? value) {
    // if (isPure) return null;
    // return value.isEmpty ? NotEmptyNumError.empty : null;
    if (value?.isNotEmpty ?? false) {
      return reg.hasMatch(value!) ? null : NotEmptyNumError.invalid;
    } else {
      return NotEmptyNumError.empty;
    }
  }

}
