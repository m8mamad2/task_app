import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:taskapp/src/view/data/model/auth_req_model.dart';
import 'package:taskapp/src/view/domain/usecase/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthUsecase usecase;
  AuthBloc(this.usecase) : super(InitialAuthState()) {
    
    on<SignupAuthEvent>((event, emit) async {
      emit(LoadingAuthState());
      try{
        await usecase.signup(event.data)  
          .then((value) => value.values.first 
            ? emit(SuccessAuthState()) 
            : emit(FailAuthState(value.keys.first)));
      }
      catch(e){ emit(FailAuthState( e.toString() )); }
    });

    on<LoginAuthEvent>((event, emit)async {
      emit(LoadingAuthState());
      try{
        await usecase.login(event.data)  
          .then((value) => value.values.first 
            ? emit(SuccessAuthState()) 
            : emit(FailAuthState(value.keys.first)));
      }
    catch(e){ emit(FailAuthState( e.toString() )); }
     });
    
    on<ForgotPasswordAuthEvent>((event, emit) { });
  }
}
