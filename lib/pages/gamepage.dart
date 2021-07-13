import 'package:flutter/material.dart';
import 'package:parcial2proyectofinal/model/juegosmodel.dart';
import 'package:parcial2proyectofinal/providers/juegosprovider.dart';

class GamesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;
    final ModelGames games =
        ModalRoute.of(context)!.settings.arguments as ModelGames;

    return Scaffold(
      appBar: AppBar(
        elevation: 50,
        backgroundColor: Colors.red,
        title: Text(games.name!),
      ),
      body: Stack(children: [
        Positioned(
            child: Image.network(
          'https://www.wallpapertip.com/wmimgs/39-392808_super-mario-bros-wallpaper-android.jpg',
          fit: BoxFit.cover,
          width: 600,
        )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            datos('Imagenes del juego'),
            Stack(
              children: [
                Container(
                  child: ScreenShoots(games),
                ),
              ],
            ),
            datos('Nombre del Juego'),
            SizedBox(height: 20),
            datos(games.name!),
            SizedBox(height: 20),
            datos('Fecha de lanzamiento'),
            SizedBox(height: 20),
            datos(games.daterelease!),
          ],
        )
      ]),
    );
  }

  Widget datos(dato) {
    return Text(
      dato,
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28),
    );
  }
}

class ScreenShoots extends StatelessWidget {
  ModelGames games;
  ScreenShoots(this.games);
  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;
    return SizedBox(
      height: mediaquery.height * 0.4,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (int i = 0; i < 6; i++)
            Image.network(
              games.screenshoots![i]['images'][0]['url'],
              width: 510,
            )
        ],
      ),
    );
  }
}
