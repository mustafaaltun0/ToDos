import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/data/entity/todos.dart';
import 'package:todos/ui/cubit/anasayfa_cubit.dart';
import 'package:todos/ui/cubit/detay_sayfa_cubit.dart';
import 'package:todos/ui/cubit/kayit_sayfa_cubit.dart';
import 'package:todos/ui/views/detay_sayfa.dart';
import 'package:todos/ui/views/kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  // Arama yapılıp yapılmadığını kontrol eden değişken
  bool _aramaYapiliyorMu = false;

  @override
  void initState() {
    super.initState();
    // Sayfa ilk yüklendiğinde mevcut görevleri yükler
    context.read<AnasayfaCubit>().TodosYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),        // Üst barı (AppBar) oluşturur
      body: _buildTodoList(),        // Görev listesini gösterir
      floatingActionButton: _buildFloatingActionButton(), // Yeni görev ekleme butonu
    );
  }

  // Uygulamanın üst barını oluşturur
  AppBar _buildAppBar() {
    return AppBar(
      // Arama yapılıyorsa arama çubuğu gösterir, değilse "Todos" başlığını gösterir
      title: _aramaYapiliyorMu ? _buildSearchField() : const Text("Todos"),
      actions: [
        // Arama yapılıyorsa temizleme butonunu, yapılmıyorsa arama butonunu gösterir
        _aramaYapiliyorMu ? _buildClearSearchButton() : _buildSearchButton()
      ],
    );
  }

  // Arama yapılabilmesi için bir text alanı sağlar
  TextField _buildSearchField() {
    return TextField(
      decoration: const InputDecoration(hintText: "Ara"),
      onChanged: (aramaSonucu) {
        // Arama alanındaki yazıya göre görevleri filtreler
        context.read<AnasayfaCubit>().ara(aramaSonucu);
      },
    );
  }

  // Arama çubuğunu temizlemek için bir buton sağlar
  IconButton _buildClearSearchButton() {
    return IconButton(
      onPressed: () {
        setState(() => _aramaYapiliyorMu = false); // Arama durumunu kapatır
        context.read<AnasayfaCubit>().TodosYukle(); // Tüm görevleri tekrar yükler
      },
      icon: const Icon(Icons.clear),
    );
  }

  // Arama çubuğunu açmak için bir buton sağlar
  IconButton _buildSearchButton() {
    return IconButton(
      onPressed: () {
        setState(() => _aramaYapiliyorMu = true); // Arama durumunu açar
      },
      icon: const Icon(Icons.search),
    );
  }

  // Görevleri liste halinde gösterir
  BlocBuilder<AnasayfaCubit, List<Todos>> _buildTodoList() {
    return BlocBuilder<AnasayfaCubit, List<Todos>>(
      builder: (context, todosListesi) {
        // Eğer görev listesi boş değilse, görevleri listeler
        if (todosListesi.isNotEmpty) {
          return ListView.builder(
            itemCount: todosListesi.length,
            itemBuilder: (context, indeks) {
              var todo = todosListesi[indeks];
              return _buildTodoItem(todo); // Her görevi bir liste öğesi olarak oluşturur
            },
          );
        } else {
          // Görev listesi boşsa, boş bir merkez widget gösterir
          return const Center(child: Text("Henüz yapılacak iş yok"));
        }
      },
    );
  }

  // Tek bir görev öğesini oluşturur
  GestureDetector _buildTodoItem(Todos todo) {
    return GestureDetector(
      onTap: () => _navigateToDetailPage(todo), // Tıklandığında detay sayfasına yönlendirir
      child: Card(
        child: ListTile(
          title: Text(todo.name, style: const TextStyle(fontSize: 20)), // Görev adını gösterir
          trailing: _buildDeleteButton(todo), // Silme butonunu gösterir
        ),
      ),
    );
  }

  // Görevi silmek için kullanılan buton
  IconButton _buildDeleteButton(Todos todo) {
    return IconButton(
      onPressed: () {
        // Silme onayı için bir Snackbar gösterir
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${todo.name} silinsin mi?"),
            action: SnackBarAction(
              label: "Evet",
              onPressed: () => context.read<AnasayfaCubit>().sil(todo.id), // "Evet"e tıklanırsa görevi siler
            ),
          ),
        );
      },
      icon: const Icon(Icons.clear, color: Colors.black54),
    );
  }

  // Yeni görev eklemek için bir buton sağlar
  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: _navigateToAddPage, // Tıklanırsa yeni görev ekleme sayfasına yönlendirir
      child: const Icon(Icons.add),
    );
  }

  // Görev detay sayfasına yönlendiren fonksiyon
  void _navigateToDetailPage(Todos todo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => DetaySayfaCubit(),
          child: DetaySayfa(todo: todo),
        ),
      ),
    ).then((_) => context.read<AnasayfaCubit>().TodosYukle()); // Detay sayfası kapandıktan sonra görevleri günceller
  }

  // Yeni görev ekleme sayfasına yönlendiren fonksiyon
  void _navigateToAddPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => KayitSayfaCubit(),
          child: const KayitSayfa(),
        ),
      ),
    ).then((_) => context.read<AnasayfaCubit>().TodosYukle()); // Yeni görev eklendikten sonra görevleri günceller
  }
}
