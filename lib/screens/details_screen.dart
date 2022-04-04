import 'package:flutter/material.dart';
import 'package:peliculas/models/models_imports.dart';
import 'package:peliculas/widgets/all_widgets.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //Todo: Cambiar Luego a una instanci de movie

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomappBar(movie),
          SliverList(
              delegate: SliverChildListDelegate([
            _Posterytitulo(movie),
            _Overview(movie),
            _Overview(movie),
            _Overview(movie),
            CardActor(movie.id),
          ]))
        ],
      ),
    );
  }
}

//Todo: Portada de detalles
class _CustomappBar extends StatelessWidget {
  final Movie movie;
  const _CustomappBar(this.movie);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
          child: Text(
            movie.title,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        //ajustar portada de las imagenes de las peliculas
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullbackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _Posterytitulo extends StatelessWidget {
  final Movie movie;

  const _Posterytitulo(this.movie);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textstilo = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/loading.gif'),
                image: NetworkImage(movie.posterpeliculas),
                height: 150,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: size.width - 190),
                  child: Text(
                    movie.title,
                    maxLines: 2,
                    style: textstilo.headline6,
                    overflow: TextOverflow.ellipsis,
                  )),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width - 190),
                child: Text(
                  movie.originalTitle,
                  style: textstilo.subtitle1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star_border,
                    size: 30,
                    color: Colors.grey,
                  ),
                  Text(
                    movie.voteAverage.toString(),
                    style: textstilo.subtitle2,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Movie movie;

  const _Overview(this.movie);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
