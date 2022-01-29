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
      home: Builder(    // Add this widget to allow using MaterialApp's 'context' and not the class' one
        builder: (context) {
          return Scaffold(
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
                  // TODO: Consider changing the Radio widgets into ToggleButtons
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
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResult()));
                      },
                      child: Text('Show Results'),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

class SearchResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Space Finder (Result Page)'),
          backgroundColor: Colors.lightBlue,
        ),
        body: Column(
          children: [
            Text('Search Results'),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.image),
                  Column(
                    children: [
                      Text('Location Name 1'),
                      Row(
                        children: [
                          Icon(Icons.star),
                          Icon(Icons.star),
                          Icon(Icons.star),
                          Icon(Icons.star),
                          Icon(Icons.star_border),
                        ],
                      )
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // TODO: Navigate to a new page that shows more details
                      },
                      child: Text('Check Details')
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }


}