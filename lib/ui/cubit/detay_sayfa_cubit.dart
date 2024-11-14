import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/data/repo/todosdao_repository.dart';


class DetaySayfaCubit extends Cubit<void>{
  DetaySayfaCubit():super(0);

  var krepo = TodosdaoRepository();

  Future<void> guncelle(int id, String name) async {
    await krepo.guncelle(id, name);
  } 
}