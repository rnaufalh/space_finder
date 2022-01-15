import 'package:flutter/material.dart';

void main() => runApp(SpaceFinder());

enum SingingCharacter { open, closed }

class SpaceFinder extends StatefulWidget {
  _SpaceFinderState createState() => _SpaceFinderState();
}

class _SpaceFinderState extends State<SpaceFinder> {
  SingingCharacter? _character = SingingCharacter.open;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Space Finder'),
          backgroundColor: Colors.lightBlue,
        ),
        body: Container(
          child: Column(
            children: <Widget> [
              Row(
                children: <Widget> [
                  Expanded(child: Text('Open or Closed Space?')),
                  Expanded(
                    child: ListTile(
                      title: Text('Open'),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.open,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text('Closed'),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.closed,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}