import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/faliure.dart';
import '../../../../core/usecase/base_useCase.dart';
import '../entities/post_new_user_name.dart';
import '../repository/base_auth_repository.dart';

class PostingTheNewUserNameUseCase extends BaseUseCase<PostNewUserName, NewUserNameParameters> {
  final BaseAuthRepository baseMovieRepository;

  PostingTheNewUserNameUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, PostNewUserName>> call(NewUserNameParameters parameters) async {
    return await baseMovieRepository.postNewUserName(parameters);
  }
}

class NewUserNameParameters extends Equatable {
  final String name;

  const NewUserNameParameters(
      {required this.name,});

  @override
  List<Object> get props => [
        name,
      ];
}
