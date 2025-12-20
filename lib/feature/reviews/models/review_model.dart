import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String author;
  final String text;

  const Review({required this.author, required this.text});

  @override
  List<Object> get props => [author, text];
}
