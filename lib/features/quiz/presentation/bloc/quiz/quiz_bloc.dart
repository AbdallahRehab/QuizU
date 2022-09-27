import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quizu/core/usecase/base_useCase.dart';
import 'package:quizu/core/utills/enums.dart';
import 'package:quizu/features/quiz/domain/entities/questions.dart';
import 'package:quizu/features/quiz/domain/usecases/get_questions_usecase.dart';
import 'package:quizu/features/quiz/domain/usecases/post_score_usecase.dart';
import 'package:quizu/features/quiz/domain/usecases/set_score_data_locally_state.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final GetQuestionsUseCase getQuestionsUseCase;
  final PostScoreUseCase postScoreUseCase;
  final SetScoreDataLocallyStateUseCase setScoreDataLocallyStateUseCase;

  QuizBloc({
    required this.getQuestionsUseCase,
    required this.postScoreUseCase,
    required this.setScoreDataLocallyStateUseCase,
  }) : super(const QuizState()) {
    on<GetQuestionsEvent>(
      _getQuestions,
    );
    on<SetScoreDataEvent>(
      _setScoreData,
    );

    on<PostScoreEvent>(
      _postScoreEvent,
    );
  }

  FutureOr<void> _getQuestions(
      GetQuestionsEvent event, Emitter<QuizState> emit) async {
    final result = await getQuestionsUseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
            questionsState: RequestState.error, questionsMessage: l.message)),
        (r) => emit(
            state.copyWith(questions: r, questionsState: RequestState.loaded)));
  }

  FutureOr<void> _setScoreData(
      SetScoreDataEvent event, Emitter<QuizState> emit) async {
    // emit(state.copyWith(signUpState: RequestState.loading));

    final result =
        await setScoreDataLocallyStateUseCase( ScoreDataLocallyParameters(
      score: event.Score,
    ));

    result.fold((l) => emit(state), (r) => emit(state));
  }

  FutureOr<void> _postScoreEvent(
      PostScoreEvent event, Emitter<QuizState> emit) async {
    final result = await postScoreUseCase(ScoreParameters(Score: event.Score));

    result.fold((l) => emit(state), (r) => emit(state));

    if (result.isRight()) {
      final resultSaveUserData = await setScoreDataLocallyStateUseCase(
           ScoreDataLocallyParameters(
        score: event.Score,
      ));
    }
  }

  int? indexSelectedAnswer;
  int numberOfQuestion = 0;
  int scoreUserInQuiz = 0;

  updateIndexSelectedAnswer(
      {required int value,
      required String keySelected,
      required String correctAnswer}) {
    indexSelectedAnswer = value;
    emit(state.copyWith(isCorrect: false));
    if (keySelected == correctAnswer) {
      // emit(state.copyWith(changeIndexSelectedAnswer: value));

      if (state.questions.length - 1 > numberOfQuestion) {
        numberOfQuestion++;
      }
      indexSelectedAnswer = null;
      scoreUserInQuiz++;
      emit(state.copyWith(
          changeNumberOfQuestion: numberOfQuestion,
          changeIndexSelectedAnswer: 4,
          isCorrect: true,
          scoreUserInQuiz: scoreUserInQuiz
      ));
      print('scoreUserInQuiz $scoreUserInQuiz');
    }else{
      emit(state.copyWith(changeIndexSelectedAnswer: value));
    }


  }

  updateNumberOfQuestion() {
    if (state.questions.length - 1 > numberOfQuestion) {
      numberOfQuestion++;
    }
    indexSelectedAnswer = null;
    emit(state.copyWith(
        changeNumberOfQuestion: numberOfQuestion,
        changeIndexSelectedAnswer: 4,
        isSkip: true,
        isCorrect: false));
  }
}
