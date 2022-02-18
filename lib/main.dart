import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:space_finder/study_space_brain.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(SpaceFinder());

StudySpaceBrain studySpaceBrain = new StudySpaceBrain();

String _searchHint = "Still Empty...";

class SpaceFinder extends StatefulWidget {
  _SpaceFinderState createState() => _SpaceFinderState();
}

class _SpaceFinderState extends State<SpaceFinder> {
  @override
  Widget build(BuildContext context) {

    studySpaceBrain.extractData(); // Call method to fill the library list

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
                    child: Text('Search Your Library'),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: TextField(
                      onSubmitted: (value) {
                        _searchHint = value;

                        // Move to the next page to see the search result
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResult()));
                      },
                      decoration: InputDecoration(
                        hintText: 'Please search here...',
                        suffixIcon: Icon(Icons.search)
                      ),
                    ),
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
            //Text(_searchHint),    // <== These are the search results
            //Text(studySpaceBrain.getTotalSimilarItems(testVal).toString()),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black
                )
              ),

              // TODO: When all list is shown, it will overflow the screen. Find a way to mitigate this.
              child: Column(
                children: [
                  if (studySpaceBrain.getSimilarItems(_searchHint).length == 0)
                    Center(
                      child: Text('No Results Found, Try Again'),
                    ),
                  for (var i in studySpaceBrain.getSimilarItems(_searchHint))
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.image),
                        Column(
                          children: [
                            Text(studySpaceBrain.getLocationName(i)),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () async {

                              // Navigate the link to the library's official page
                              if (!await launch(studySpaceBrain.getLibraryLink(i))) throw 'Could not launch';

                            },
                            child: Text('Check Details')
                        ),
                      ],
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