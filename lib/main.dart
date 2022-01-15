import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(SpaceFinder());

enum SpaceType { open, closed }
enum QuietRoomChoices { yes, no }

class SpaceFinder extends StatefulWidget {
  _SpaceFinderState createState() => _SpaceFinderState();
}

class _SpaceFinderState extends State<SpaceFinder> {
  SpaceType? _spaceType = SpaceType.open;
  QuietRoomChoices? _quietRoomChoices = QuietRoomChoices.no;

  List<bool> _selections = List.generate(4, (_) => false);

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
              Center(
                child: Text('Describe Your Preference'),
              ),
              Row(
                children: <Widget> [
                  Expanded(child: Text('Do you want a Quiet Room to study in?')),
                  Expanded(
                    child: ListTile(
                      title: Text('Yes'),
                      leading: Radio<QuietRoomChoices>(
                        value: QuietRoomChoices.yes,
                        groupValue: _quietRoomChoices,
                        onChanged: (QuietRoomChoices? value) {
                          setState(() {
                            _quietRoomChoices = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text('No'),
                      leading: Radio<QuietRoomChoices>(
                        value: QuietRoomChoices.no,
                        groupValue: _quietRoomChoices,
                        onChanged: (QuietRoomChoices? value) {
                          setState(() {
                            _quietRoomChoices = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget> [
                  Expanded(child: Text('Open or Closed Space?')),
                  Expanded(
                    child: ListTile(
                      title: Text('Open'),
                      leading: Radio<SpaceType>(
                        value: SpaceType.open,
                        groupValue: _spaceType,
                        onChanged: (SpaceType? value) {
                          setState(() {
                            _spaceType = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text('Closed'),
                      leading: Radio<SpaceType>(
                        value: SpaceType.closed,
                        groupValue: _spaceType,
                        onChanged: (SpaceType? value) {
                          setState(() {
                            _spaceType = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget> [
                  Expanded(child: Text('How many are going?')),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue: '1',
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.0,),
              Text('Select your desired facilities:'),
              SizedBox(height: 10.0,),
              ToggleButtons(
                  children: <Widget> [
                    Icon(Icons.ac_unit),
                    Icon(Icons.tv),
                    Icon(Icons.microwave),
                    Icon(Icons.local_drink),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      _selections[index] = !_selections[index];
                    });
                  },
                  isSelected: _selections
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      // TODO: Enable saving values to be used on next page
                    });
                  },
                  child: Text('Show Results'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}