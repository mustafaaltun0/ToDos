import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/data/entity/todos.dart';
import 'package:todos/data/repo/todosdao_repository.dart';

class AnasayfaCubit extends Cubit<List<Todos>>{
    AnasayfaCubit():super(<Todos>[]);

    var krepo= TodosdaoRepository();
    
    Future<void>TodosYukle() async{
    var list = await krepo.TodosYukle();
    emit(list);
  }

    Future<void>ara(String aramaKelimesi) async{
    var liste = await krepo.ara(aramaKelimesi);
    emit(liste);
  }

  Future<void> sil(int id) async{
    await krepo.sil(id);
    await TodosYukle();
  }
}