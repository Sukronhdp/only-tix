import 'package:only_tix/data/repositories/authentication.dart';
import 'package:only_tix/domain/entities/result.dart';
import 'package:only_tix/domain/usecases/usecase.dart';

class Logout implements UseCase<Result<void>, void> {
  final Authentication _authentication;

  Logout({required Authentication authentication})
      : _authentication = authentication;

  @override
  Future<Result<void>> call(void params) {
    return _authentication.logout();
  }
}
