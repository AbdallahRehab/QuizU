part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object?> get props => [];
}

class PostScoreEvent extends QuizEvent {
  final String Score;

  const PostScoreEvent({required this.Score});

  @override
  List<Object> get props => [Score];
}

class SetScoreDataEvent extends QuizEvent {
  final String Score;

  const SetScoreDataEvent({required this.Score});

  @override
  List<Object> get props => [Score];
}

class GetQuestionsEvent extends QuizEvent {
  const GetQuestionsEvent();

  @override
  List<Object> get props => [];
}
