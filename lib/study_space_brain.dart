import 'study_space.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;


class StudySpaceBrain {
  List<String> _libraryNames = [];
  List<StudySpace> _studySpaceData =[];

  // Implement web scrapping to obtain the list of library and their website links
  Future extractData() async {
    final response = await http.Client().get(Uri.parse('https://web.library.uq.edu.au/locations-hours'));
    var counter = 0;

    if (response.statusCode == 200) { // Status code 200 = Response Received Successfully
      var document = parser.parse(response.body); // Get the html document from response

      try {
        while (true) {
          var libraryRow = document.getElementsByTagName('tbody')[0].children[counter].children[0];

          var libraryName = libraryRow.children[0].text.trim();   // To obtain the library name
          var libraryLink = libraryRow.getElementsByTagName('a').map((e) => e.attributes['href']).toList();   // To obtain the link within the element

          print(libraryName);
          print('https://web.library.uq.edu.au'+libraryLink[0].toString());

          StudySpace libraryObject = StudySpace(
              locationName: libraryName,
              libraryLink: ('https://web.library.uq.edu.au'+libraryLink[0].toString()));

          // Check if the library is in the list, then add it if not
          if (!_libraryNames.contains(libraryName)) {
            _libraryNames.add(libraryName);
            _studySpaceData.add(libraryObject);
          }
          counter++;
        }
      } catch (e) {
        if (_studySpaceData.isNotEmpty) {
          print('Web Scrapping Successful');
        } else {
          print('Web Scrapping not Successful');
        }
      }
    } else {
      print('Response from URL not 200');
    }
  }

  // Get library name of object
  String getLocationName(int index) {
    return _studySpaceData[index].locationName;
  }

  // Get library website's link of object
  String getLibraryLink(int index) {
    return _studySpaceData[index].libraryLink;
  }

  // Get items' indexes if the item matches to the user's search
  List<int> getSimilarItems(String hint) {
    List<int> resultIndexes = [];
    int counter = 0;
    for (var studySpace in _studySpaceData) {
      String locNameLower = studySpace.locationName.toLowerCase();
      if (locNameLower.contains(hint.toLowerCase())) {
        resultIndexes.add(counter);
      }
      counter++;
    }

    return resultIndexes;
  }
}

