import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/data/entity/todos.dart';
import 'package:todos/ui/cubit/detay_sayfa_cubit.dart';

class DetaySayfa extends StatefulWidget {
  final Todos todo; // 'final' olarak tanımlandı

  DetaySayfa({Key? key, required this.todo}) : super(key: key);

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  var tfname = TextEditingController();

  @override
  void initState() {
    super.initState();
    tfname.text = widget.todo.name; // todo.name başlangıçta TextField’a atanıyor
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detay Sayfa"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Görev adını düzenlemek için bir TextField
              TextField(
                controller: tfname,
                decoration: const InputDecoration(hintText: "Name"),
              ),
              // Görevi güncelleme işlemi için bir buton
              ElevatedButton(
                onPressed: () {
                  context.read<DetaySayfaCubit>().guncelle(widget.todo.id, tfname.text);
                },
                child: const Text("GÜNCELLEME"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
