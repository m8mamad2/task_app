import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:taskapp/src/view/data/model/task_model.dart';
import 'package:taskapp/src/view/domain/usecase/task_usecase.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final TaskUseCase useCase;
  SearchBloc(this.useCase) : super(SuccessSearchState([])) {
    
    on<SearchReqEvent>((event, emit) async{
      emit(LoadingSearchState());
      try{
        await useCase.serachTask(event.search)
          .then((value) async => value.values.first == 'ok'
            ? emit(SuccessSearchState( value.keys.first ))
            : emit(FailSearchState('Fail To Add Task'))  );
      }
      catch(e){ emit(FailSearchState(e.toString())); }

    });
  }
}
