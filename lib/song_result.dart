import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class eiei extends StatelessWidget {
  String? song_name;
  String? song_artist;
  String? song_date;
  String song_video;
  String? song_director;
  String? song_kname;

  eiei(
    this.song_name,
    this.song_artist,
    this.song_date,
    this.song_video,
    this.song_director,
    this.song_kname,
  );

  String? myVideoId;

  @override
  Widget build(BuildContext context) {
    myVideoId = YoutubePlayer.convertUrlToId(song_video);

    final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: '$myVideoId',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter and Youtube'),
        ),
        body: Column(
          children: [
            YoutubePlayer(
              controller: _controller,
              liveUIColor: Colors.amber,
            ),
            Text("$song_name")
          ],
        ));
  }
}

class song_result extends StatelessWidget {
  String? song_name;
  String? song_artist;
  String? song_date;
  String? song_video;
  String? song_director;
  String? song_kname;

  song_result(
    this.song_name,
    this.song_artist,
    this.song_date,
    this.song_video,
    this.song_director,
    this.song_kname,
  );

  String? myVideoId;

  @override
  Widget build(BuildContext context) {
    myVideoId = YoutubePlayer.convertUrlToId('$song_video');

    final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: '$myVideoId',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 70.0),
        Icon(
          Icons.music_note,
          color: Colors.white,
          size: 40.0,
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.white),
        ),
        SizedBox(height: 10.0),
        Text(
          // idol name
          '$song_name',
          style: TextStyle(color: Colors.white, fontSize: 35),
        ),
        SizedBox(height: 25.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      // idol korea name
                      '$song_artist',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ))),
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            // height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration()),
        Container(
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color(0xFFE588A5)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
        )
      ],
    );
    final sonfinfo = Text(
      '$song_kname | $song_date',
      style: TextStyle(fontSize: 18),
    );
    final director = Text(
      '$song_director',
      style: TextStyle(fontSize: 18),
    );

    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Align(alignment: Alignment.centerLeft, child: sonfinfo),
            Align(alignment: Alignment.centerLeft, child: director),
          ],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[
          topContent,
          YoutubePlayer(
            controller: _controller,
            liveUIColor: Colors.amber,
          ),
          bottomContent
        ],
      ),
    );
  }
}
