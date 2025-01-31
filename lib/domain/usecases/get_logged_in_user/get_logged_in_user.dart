import 'package:only_tix/data/repositories/authentication.dart';
import 'package:only_tix/data/repositories/user_repository.dart';
import 'package:only_tix/domain/entities/result.dart';
import 'package:only_tix/domain/entities/user.dart';
import 'package:only_tix/domain/usecases/usecase.dart';

class GetLoggedInUser implements UseCase<Result<User>, void> {
  final Authentication _authentication;
  final UserRepository _userRepository;

  GetLoggedInUser(
      {required Authentication authentication,
      required UserRepository userRepository})
      : _authentication = authentication,
        _userRepository = userRepository;

  @override
  Future<Result<User>> call(void params) async {
    String? LoggedId = _authentication.getLoggedInUserId();
    if (LoggedId != null) {
      var userResult = await _userRepository.getUser(uid: LoggedId);

      if (userResult.isSuccess) {
        return Result.success(userResult.resultValue!);
      } else {
        return Result.failed(userResult.errorMessage!);
      }
    } else {
      return const Result.failed('No user logged in');
    }
  }
}
