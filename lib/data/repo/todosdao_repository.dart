import 'package:todos/data/entity/todos.dart';
import 'package:todos/sqlite/veritabani_yardimcisi.dart';

class TodosdaoRepository {
  Future<List<Todos>> ara(String aramaKelimesi) async {
  var db = await VeritabaniYardimcisi.veritabaniErisim();
  List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM Todos WHERE name like '%$aramaKelimesi%'");

  return List.generate(maps.length, (i) {
    var satir = maps[i];
    return Todos(id: satir["id"], name: satir["name"]);
  });
}



  Future<void> sil(int id) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    await db.delete("Todos",where: "id = ?",whereArgs: [id]);
  }


  Future<List<Todos>>TodosYukle() async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM Todos");

    return List.generate(maps.length, (i){
      var satir = maps[i];
      return Todos(id: satir["id"],name: satir["name"]);
    });
  }

  Future<void> guncelle(int id, String name) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var guncellenenTodos = Map<String,dynamic>();
    guncellenenTodos["name"] = name;
    await db.update("Todos", guncellenenTodos,where: "id = ?",whereArgs: [id]);
  }
  Future<void> kaydet(String name) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var yenitodo = Map<String,dynamic>();
    yenitodo["name"] = name;
    await db.insert("Todos", yenitodo);
  }
}