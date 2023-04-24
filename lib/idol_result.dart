import 'package:flutter/material.dart';

class idol_result extends StatelessWidget {
  String? name;
  String? kname;
  String? sname;
  String? idol_dob;
  String? idol_group;
  String? idol_country;
  String? idol_height;
  String? idol_weight;
  String? idol_gender;
  String? idol_birthplace;

  idol_result(
      this.name,
      this.kname,
      this.sname,
      this.idol_dob,
      this.idol_group,
      this.idol_country,
      this.idol_height,
      this.idol_weight,
      this.idol_gender,
      this.idol_birthplace);

  @override
  Widget build(BuildContext context) {
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 100.0),
        Icon(
          Icons.person,
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
          '$name',
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
                      '$kname',
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
          // height: MediaQuery.of(context).size.height * 0.5,
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
    final stagename = Text(
      'Stage Name: $sname',
      style: TextStyle(fontSize: 18),
    );
    final dob = Text(
      'Date of Birth: $idol_dob',
      style: TextStyle(fontSize: 18),
    );
    final group = Text(
      'Group: $idol_group',
      style: TextStyle(fontSize: 18),
    );
    final height = Text(
      'Height: $idol_height',
      style: TextStyle(fontSize: 18),
    );
    final weight = Text(
      'Weight: $idol_weight',
      style: TextStyle(fontSize: 18),
    );
    final country = Text(
      'Country: $idol_country',
      style: TextStyle(fontSize: 18),
    );
    final gender = Text(
      'Gender: $idol_gender',
      style: TextStyle(fontSize: 18),
    );
    final birthplace = Text(
      'Birthplace: $idol_birthplace',
      style: TextStyle(fontSize: 18),
    );

    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Align(alignment: Alignment.centerLeft, child: stagename),
            SizedBox(
              height: 20,
            ),
            Align(alignment: Alignment.centerLeft, child: dob),
            SizedBox(
              height: 20,
            ),
            Align(alignment: Alignment.centerLeft, child: group),
            SizedBox(
              height: 20,
            ),
            Align(alignment: Alignment.centerLeft, child: height),
            SizedBox(
              height: 20,
            ),
            Align(alignment: Alignment.centerLeft, child: weight),
            SizedBox(
              height: 20,
            ),
            Align(alignment: Alignment.centerLeft, child: gender),
            SizedBox(
              height: 20,
            ),
            Align(alignment: Alignment.centerLeft, child: birthplace),
            SizedBox(
              height: 20,
            ),
            Align(alignment: Alignment.centerLeft, child: country)
          ],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}
