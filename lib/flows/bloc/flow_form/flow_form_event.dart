part of 'flow_form_bloc.dart';

abstract class FlowFormEvent extends Equatable {
  const FlowFormEvent();
  @override
  List<Object> get props => [];
}

class FieldChanged extends FlowFormEvent {
  const FieldChanged(this.field);
  final Map<String, dynamic> field;
  @override
  List<Object> get props => [field];
}

class AccountChanged extends FlowFormEvent {
  const AccountChanged(this.value);
  final dynamic value;
  @override
  List<Object> get props => [value];
}

class CategoryChanged extends FlowFormEvent {
  const CategoryChanged(this.categories);
  final List<dynamic> categories;
  @override
  List<Object> get props => [categories];
}

class CategoryAmountChanged extends FlowFormEvent {
  const CategoryAmountChanged(this.categoryId, this.amount);
  final int categoryId;
  final String amount;
  @override
  List<Object> get props => [categoryId, amount];
}

class CategoryConvertedAmountChanged extends FlowFormEvent {
  const CategoryConvertedAmountChanged(this.categoryId, this.convertedAmount);
  final int categoryId;
  final String convertedAmount;
  @override
  List<Object> get props => [categoryId, convertedAmount];
}

class TabIndexChanged extends FlowFormEvent {
  const TabIndexChanged(this.tabIndex);
  final int tabIndex;
  @override
  List<Object> get props => [tabIndex];
}

class CurrentBookChanged extends FlowFormEvent {
  const CurrentBookChanged(this.currentBook);
  final Map<String, dynamic> currentBook;
  @override
  List<Object> get props => [currentBook];
}

class DefaultLoaded extends FlowFormEvent {
  final int action;
  final Map<String, dynamic> currentRow;
  const DefaultLoaded(this.action, this.currentRow);
  @override
  List<Object> get props => [action, currentRow];
}

class Submitted extends FlowFormEvent { }


