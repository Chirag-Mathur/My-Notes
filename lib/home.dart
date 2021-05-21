import 'dart:async';

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import './models/Note.dart';
import 'amplifyconfiguration.dart';
import 'models/ModelProvider.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Note> notes;
  TextEditingController _notesTitle;
  TextEditingController _notesContent;
  int color = 0xffffffff;
  final AmplifyDataStore datastorePlugin =
      AmplifyDataStore(modelProvider: ModelProvider.instance);
  StreamSubscription _subscription;
  final AmplifyAPI _apiPlugin = AmplifyAPI();
  final AmplifyAuthCognito _authPlugin = AmplifyAuthCognito();
  @override
  void initState() {
    notes = [];
    _notesContent = TextEditingController();
    _notesTitle = TextEditingController();
    _initializeApp();
    super.initState();
    //_configureAmplify();
  }

  @override
  void dispose() {
    // cancel the subscription when the state is removed from the tree
    _subscription.cancel();
    super.dispose();
  }

  Future<void> _initializeApp() async {
    // configure Amplify
    await _configureAmplify();

    _subscription = Amplify.DataStore.observe(Note.classType).listen((event) {
      fetchNotes();
    });
    await fetchNotes();

    // after configuring Amplify, update loading ui state to loaded state
  }

  void createNote(String title, String content, int color) async {
    final item = Note(title: title, content: content, color: color);
    setState(() {
      notes.add(item);
    });

    await Amplify.DataStore.save(item);
    print('-----${notes.length}');
  }

  void updateNote() {
    //
  }

  Future<void> fetchNotes() async {
    try {
      List<Note> _allNotes = await Amplify.DataStore.query(Note.classType);
      setState(() {
        notes = _allNotes;
      });
      print('#######${notes.length}');
    } catch (e) {
      print('Query failed: $e');
    }
    //
  }

  void deleteNote() {
    //
  }

  Future<void> _configureAmplify() async {
    // Add the following lines to your app initialization to add the DataStore plugin

    Amplify.addPlugins([datastorePlugin, _apiPlugin, _authPlugin]);
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        child: Icon(Icons.add),
        onPressed: fetchNotes,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Chirag Notes',
                style: TextStyle(
                  fontSize: 48,
                ),
              ),
            ),
            newNote(),
            Expanded(
              child: allNotes(),
            ),
          ],
        ),
      ),
    );
  }

  Widget newNote() {
    return Container(
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(color),
      ),
      child: Column(
        children: [
          TextField(
            controller: _notesTitle,
            decoration: InputDecoration(hintText: 'Title'),
          ),
          TextField(
            controller: _notesContent,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(hintMaxLines: 3, hintText: 'Content'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    color = 0xffB22222;
                  });
                },
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Color(0xffB22222),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    color = 0xffB8860B;
                  });
                },
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Color(0xffB8860B),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    color = 0xff006400;
                  });
                },
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Color(0xff006400),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    color = 0xff008B8B;
                  });
                },
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Color(0xff008B8B),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              createNote(
                _notesTitle.text,
                _notesContent.text,
                color,
              );
            },
            child: Text('Save'),
          )
        ],
      ),
    );
  }

  Widget allNotes() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: notes.length,
        itemBuilder: (context, index) => Container(
          color: Color(notes[index].color),
          child: GridTile(
            child: Column(
              children: [
                Text(notes[index].title),
                Text(notes[index].content),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
