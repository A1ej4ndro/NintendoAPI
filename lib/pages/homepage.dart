import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcial2proyectofinal/model/juegosmodel.dart';
import 'package:parcial2proyectofinal/providers/state.dart';

class Home extends StatefulWidget {
  @override
  HomePage createState() => HomePage();
}

class HomePage extends State {
  final scrollController = ScrollController();
  bool cargando = false;
  @override
  void initState() {
    final juegos = Get.put(StateGames());
    juegos.obtenerJuegos();
    scrollController.addListener(() async {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        if (cargando == false) {
          setState(() {
            cargando = true;
          });
          await juegos.obtenerJuegos();
          setState(() {
            cargando = false;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 50,
        backgroundColor: Colors.red,
        title: Text('Nintendo Eshop'),
      ),
      body: Container(
        child: SafeArea(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              GetBuilder(
                builder: (StateGames juegos) {
                  return GridView.builder(
                    controller: scrollController,
                    itemCount: juegos.juegos.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.7,
                        crossAxisSpacing: 4.0),
                    itemBuilder: (BuildContext context, int i) {
                      final games = juegos.juegos[i];
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/games',
                            arguments: games),
                        child: Container(
                          child: Stack(
                            children: [
                              Carta(games),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              if (cargando == true)
                Center(child: CircularProgressIndicator())
              else
                Container()
            ],
          ),
        ),
      ),
    );
  }
}

class Carta extends StatelessWidget {
  ModelGames games;
  Carta(this.games);
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;
    return Container(
      height: _mediaQuery.height * 2.0,
      child: Card(
        elevation: 50,
        child: Container(
          margin: EdgeInsets.all(8.0),
          width: double.infinity,
          height: 150.0,
          child: Stack(
            children: [
              ImgGame(games),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   games.name!,
                  //   maxLines: 2,
                  // )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImgGame extends StatelessWidget {
  final ModelGames games;
  ImgGame(this.games);
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: games.name!.toString(),
      child: FadeInImage(
        placeholder: AssetImage(
          'assets/loading.gif',
        ),
        image: NetworkImage(
          games.image!,
        ),
      ),
    );
  }
}
