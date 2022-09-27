part of 'quiz_bloc.dart';

class QuizState extends Equatable {
  final List<Questions> questions;
  final RequestState questionsState;
  final String questionsMessage;

  final int? changeIndexSelectedAnswer;
  final int changeNumberOfQuestion;
  final bool isSkip;
  final bool isCorrect;
  final int scoreUserInQuiz;

  const QuizState({
    this.questions = const [],
    this.questionsState = RequestState.loading,
    this.questionsMessage = "",
    this.changeIndexSelectedAnswer,
    this.changeNumberOfQuestion = 0,
    this.isSkip = false,
    this.isCorrect = false,
    this.scoreUserInQuiz = 0,
  });

  QuizState copyWith({
    List<Questions>? questions,
    RequestState? questionsState,
    String? questionsMessage,
    int? changeIndexSelectedAnswer,
    int? changeNumberOfQuestion,
    bool? isSkip,
    bool? isCorrect,
    int? scoreUserInQuiz,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      questionsState: questionsState ?? this.questionsState,
      questionsMessage: questionsMessage ?? this.questionsMessage,
      changeIndexSelectedAnswer:
          changeIndexSelectedAnswer ?? this.changeIndexSelectedAnswer,
      changeNumberOfQuestion:
          changeNumberOfQuestion ?? this.changeNumberOfQuestion,
      isSkip: isSkip ?? this.isSkip,
      isCorrect: isCorrect ?? this.isCorrect,
      scoreUserInQuiz: scoreUserInQuiz ?? this.scoreUserInQuiz,
    );
  }

  @override
  List<Object?> get props => [
        questions,
        questionsState,
        questionsMessage,
        changeIndexSelectedAnswer,
        changeNumberOfQuestion,
        isSkip,
        isCorrect,
        scoreUserInQuiz,
      ];
}
