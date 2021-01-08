import 'package:flutter/cupertino.dart';
import 'package:anime_list_app/database.dart';
import 'package:anime_list_app/anime.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String animeName;
  String epsNumber;
  String lastSeen;
  Map<String, String> newAnime = {};
  Future _animeFuture;

  @override
  void initState() {
    _animeFuture = getAnime();
    super.initState();
  }

  getAnime() async {
    final _animeData = await DBProvider.db.getAnime();
    return _animeData;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text('Anime List'),
            trailing: CupertinoButton(
              padding: const EdgeInsets.all(8.0),
              onPressed: () {},
              child: Icon(
                CupertinoIcons.plus_square_fill,
                size: 30,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              CupertinoTextField(
                placeholder: 'Anime name',
                onChanged: (value) {
                  setState(() {
                    animeName = value;
                  });
                },
              ),
              CupertinoTextField(
                placeholder: 'Number of eps',
                onChanged: (value) {
                  setState(() {
                    epsNumber = value;
                  });
                },
              ),
              CupertinoTextField(
                placeholder: 'Last ep seen',
                onChanged: (value) {
                  setState(() {
                    lastSeen = value;
                  });
                },
              ),
              CupertinoButton(
                child: Text('Add to the database'),
                onPressed: () {
                  var newAnime = AnimeList(
                    name: animeName,
                    epsNumber: epsNumber,
                    lastSeen: lastSeen,
                  );

                  DBProvider.db.newAnime(newAnime);
                },
              ),
              FutureBuilder(
                future: _animeFuture,
                builder: (BuildContext context, animeData) {
                  switch (animeData.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                    case ConnectionState.done:
                      if (!newAnime.containsKey('name')) {
                        newAnime = Map<String, String>.from(animeData.data);
                      }
                      return Column(
                        children: [
                          Text(newAnime['name']),
                          Text(newAnime['epsNumber']),
                          Text(newAnime['lastSeen']),
                        ],
                      );
                  }
                },
              ),
            ]),
          )
        ],
      ),
    );
  }
}
