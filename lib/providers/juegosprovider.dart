import 'package:dio/dio.dart';
import 'package:parcial2proyectofinal/model/juegosmodel.dart';

class ProviderGames {
  final _http = Dio();
  Future juegos() async {
    final _url =
        'https://ec.nintendo.com/api/MX/es/search/sales?count=30&offset=0#Mexico';
    final _response = await _http.get(_url);
    final _dato = _response.data['contents'];
    //print(_dato[0]['screenshots']);
    List<ModelGames> juegos = [];
    for (int i = 0; i < 29; i++) {
      String name = _dato[i]['formal_name'];
      String image = _dato[i]['hero_banner_url'];
      String date = _dato[i]['release_date_on_eshop'];
      var screens = _dato[i]['screenshots'];
      juegos.add(ModelGames(
          image: image, name: name, daterelease: date, screenshoots: screens));
    }

    return juegos;
  }
}
