import 'package:formz/formz.dart';

enum NotEmptyError { empty }

class NotEmptyFormz extends FormzInput<String, NotEmptyError> {

  const NotEmptyFormz.pure() : super.pure('');
  const NotEmptyFormz.dirty({String value = ''}) : super.dirty(value);

  @override
  NotEmptyError? validator(String? value) {
    // if (isPure) return null;
    // return value.isEmpty ? NameError.emp null;
    return (value?.isNotEmpty ?? false) ? null : NotEmptyError.empty;
  }

}
