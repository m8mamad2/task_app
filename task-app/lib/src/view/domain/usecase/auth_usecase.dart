import 'package:taskapp/src/view/data/model/auth_req_model.dart';
import 'package:taskapp/src/view/domain/repo/auth_repo_header.dart';

class AuthUsecase{
  AuthRepoHeader repo;
  AuthUsecase(this.repo);

  Future<Map<String,bool>> signup(SignupModel data)=> repo.signup(data);
  Future<Map<String,bool>> login(LoginModel data)=> repo.login(data);
  Future forgotPassword()=> repo.forgotPassword();
}