import 'package:equatable/equatable.dart';

class InitState extends Equatable {

  final String username;
  final int bookId;
  final String bookName;
  final String groupCurrencyCode;

  const InitState({
    this.username = '',
    this.bookId = 0,
    this.bookName = '',
    this.groupCurrencyCode = ''
  });

  @override
  List<Object> get props {
    return [username, bookId, bookName, groupCurrencyCode];
  }

}