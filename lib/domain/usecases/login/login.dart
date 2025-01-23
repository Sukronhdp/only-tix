import 'package:only_tix/domain/entities/result.dart';
import 'package:only_tix/domain/entities/user.dart';
import 'package:only_tix/domain/usecases/usecase.dart';
import 'package:only_tix/data/repositories/authentication.dart';
import 'package:only_tix/data/repositories/user_repository.dart';

part 'login_params.dart';

class Login implements UseCase<Result<User>, LoginParams> {
  final Authentication authentication;
  final UserRepository userRepository;

  Login({required this.authentication, required this.userRepository});

  @override
  Future<Result<User>> call(LoginParams params) async {
    // TODO: implement call
    var idResult = await authentication.login(
        email: params.email, password: params.password);

    if (idResult is Success) {
      var userResult = await userRepository.getUser(uid: idResult.resultValue!);

      return switch (userResult) {
        Success(value: final user) => Result.success(user),
        Failed(:final message) => Result.failed(message)
      };
    } else {
      return Result.failed(idResult.errorMessage!);
    }
  }
}
