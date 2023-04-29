import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_kpop_start/find_shop.dart';
import 'idol_result.dart';
import 'song_result.dart';

class tabbar extends StatelessWidget {
  static const String _title = 'Kpop Blood Type';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData.light(useMaterial3: true),
      home: MyStatefulWidget(title: ''),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key, required this.title});
  final String title;

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  var jsonIdol;
  var jsonSong;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void getIdol(String? searchQuery) async {
    setState(() {
      jsonIdol = null; // Reset the list while fetching new data
    });
    try {
      final dio = Dio(BaseOptions(
        baseUrl: 'https://k-pop.p.rapidapi.com/',
        headers: {
          'X-RapidAPI-Key':
              '0105d62a12msh994f64dc636286ap13a361jsn0f0e3c352126',
          'X-RapidAPI-Host': 'k-pop.p.rapidapi.com'
        },
      ));
      final endpoint = 'https://k-pop.p.rapidapi.com/idols';
      final queryParams = {
        'by': 'Stage Name',
        'q': searchQuery,
      };
      var response = await dio.get(endpoint, queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'];
        print(data);
        setState(() {
          jsonIdol = data as List;
        });
      } else {
        throw Exception('Failed to connect to API');
      }
    } catch (e) {
      print(e);
    }
  }

  void getSong(String? searchQuery) async {
    setState(() {
      jsonSong = null; // Reset the list while fetching new data
    });
    try {
      final dio = Dio(BaseOptions(
        baseUrl: 'https://k-pop.p.rapidapi.com/',
        headers: {
          'X-RapidAPI-Key':
              '0105d62a12msh994f64dc636286ap13a361jsn0f0e3c352126',
          'X-RapidAPI-Host': 'k-pop.p.rapidapi.com'
        },
      ));
      final endpoint = 'https://k-pop.p.rapidapi.com/songs';
      final queryParams = {
        'by': 'Song Name',
        'q': searchQuery,
      };
      var response = await dio.get(endpoint, queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'];
        print(data);
        setState(() {
          jsonSong = data as List;
        });
      } else {
        throw Exception('Failed to connect to API');
      }
    } catch (e) {
      print(e);
    }
  }

// This controller will store the value of the search bar
  final TextEditingController _searchIdolController = TextEditingController();
  final TextEditingController _searchSongController = TextEditingController();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[];
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kpop Blood Type',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Color(0xFFE588A5),
          centerTitle: true,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.audiotrack,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Text(
                  'Songs',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Text(
                  'Idols',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.location_on,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Text(
                  'Store',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.medical_information_outlined,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Text(
                  'Our Team',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(width: 2, color: Color(0xFFE588A5)),
                  ),
                  child: TextField(
                    controller: _searchSongController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () => _searchSongController.clear(),
                      ),
                      prefixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          // Perform the search here
                          getSong(_searchSongController.text);
                        },
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          child: ListTile(
                        title: Text(jsonSong[index]['Song Name']),
                        subtitle: Text(jsonSong[index]['Artist']),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => song_result(
                                      jsonSong[index]['Song Name'],
                                      jsonSong[index]['Artist'],
                                      jsonSong[index]['Date'],
                                      jsonSong[index]['Video'],
                                      jsonSong[index]['Director'],
                                      jsonSong[index]['Korean Name'])));
                        },
                      ));
                    },
                    itemCount: jsonSong == null ? 0 : jsonSong.length,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(width: 2, color: Color(0xFFE588A5)),
                  ),
                  child: TextField(
                    controller: _searchIdolController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () => _searchIdolController.clear(),
                      ),
                      prefixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          // Perform the search here
                          getIdol(_searchIdolController.text);
                        },
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          title: Text(jsonIdol[index]['Full Name']),
                          subtitle: Text(jsonIdol[index]['Korean Name']),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => idol_result(
                                  jsonIdol[index]['Full Name'],
                                  jsonIdol[index]['Korean Name'],
                                  jsonIdol[index]['Stage Name'],
                                  jsonIdol[index]['Date of Birth'],
                                  jsonIdol[index]['Group'],
                                  jsonIdol[index]['Country'],
                                  jsonIdol[index]['Height'],
                                  jsonIdol[index]['Weight'],
                                  jsonIdol[index]['Gender'],
                                  jsonIdol[index]['Birthplace'],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    itemCount: jsonIdol == null ? 0 : jsonIdol.length,
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/K-POP_Blood_Type_1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 200),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FindShop()),
                        );
                      },
                      child: const Text(
                        'Find Nearest Shop',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(Size.zero),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFFE588A5)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/K-POP Blood Type 3.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height:
                          30), // Add an empty space with 50 pixels of height
                  Expanded(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage('assets/blue.jpg'),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Poomrapee Wareeboutr',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 33, 74, 132)),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Software Engineer Student',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 29, 72, 132)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage('assets/kwang.jpg'),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Pitchaya Teerawongpairoj',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 33, 74, 132)),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Database & Intelligent Systems Student',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 29, 72, 132)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage('assets/jenny.jpg'),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Sasima Srijanya',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 33, 74, 132)),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Database & Intelligent Systems Student',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 29, 72, 132)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
