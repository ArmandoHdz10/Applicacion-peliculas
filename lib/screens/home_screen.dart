import 'package:flutter/material.dart';
import 'package:peliculas/Search/search_delagate.dart';
import 'package:peliculas/providers/movie_provider.dart';
import 'package:peliculas/widgets/all_widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesproviders = Provider.of<MovieProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Peliculas'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () =>
                  showSearch(context: context, delegate: MovieSearchDelegate()),
              icon: const Icon(Icons.search_sharp)),
        ],
      ),
      // ignore: avoid_unnecessary_containers
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text('Cartelera',
                style: TextStyle(
                  fontSize: 25,
                )),
            const SizedBox(
              height: 10,
            ),
            //! Creacion de las tarjetas  y listado horizontal//
            TarjetasSwiper(movies: moviesproviders.listadoP),
            const SizedBox(
              height: 15,
            ),
            //! Creacion de slider horizontal
            MovilSlider(
              movies: moviesproviders.listadopopulares,
              onNextPage: () => moviesproviders.getOndisplayPopular(),
            )
          ],
        ),
      ),
    );
  }
}
