part of 'language_bloc.dart';

class LanguageState extends Equatable {

  final Language selectedLanguage;

  const LanguageState({
    this.selectedLanguage = Language.chinese
  });

  @override
  List<Object> get props => [selectedLanguage];

  LanguageState copyWith({
    Language? selectedLanguage
  }) {
    return LanguageState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }

}