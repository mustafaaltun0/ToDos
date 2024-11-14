import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/data/repo/todosdao_repository.dart';

class KayitSayfaCubit extends Cubit<void> {

  KayitSayfaCubit():super(0);
   var krepo = TodosdaoRepository();

  Future<void> kaydet(String name) async {
    await krepo.kaydet(name);
  }
}