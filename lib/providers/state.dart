import 'package:get/get.dart';
import 'package:parcial2proyectofinal/model/juegosmodel.dart';
import 'package:parcial2proyectofinal/providers/juegosprovider.dart';

class StateGames extends GetxController {
  List<ModelGames> juegos = [];
  final providerGames = ProviderGames();

  Future<void> obtenerJuegos() async {
    juegos.addAll(await providerGames.juegos());
    update();
  }
}
