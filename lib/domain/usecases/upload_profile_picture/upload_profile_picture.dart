import 'package:only_tix/data/repositories/user_repository.dart';
import 'package:only_tix/domain/entities/result.dart';
import 'package:only_tix/domain/entities/user.dart';
import 'package:only_tix/domain/usecases/upload_profile_picture/upload_profile_picture_param.dart';
import 'package:only_tix/domain/usecases/usecase.dart';

class UploadProfilePicture
    implements UseCase<Result<User>, UploadProfilePictureParam> {
  final UserRepository _userRepository;

  UploadProfilePicture({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Result<User>> call(UploadProfilePictureParam params) => _userRepository
      .uploadProfilePicture(user: params.user, imageFile: params.imageFile);
}
