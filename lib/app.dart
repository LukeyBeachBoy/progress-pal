import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'styles.dart';

class ProgressApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: HomePage(),
      theme: CupertinoThemeData(
          brightness: Brightness.dark,
          textTheme: CupertinoTextThemeData(brightness: Brightness.dark)),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        decoration: Styles.backgroundGradient,
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Positioned(
                right: 0,
                child: CupertinoButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => NewHabit()),
                    );
                  },
                  child: Icon(
                    CupertinoIcons.ellipsis,
                    color: CupertinoColors.extraLightBackgroundGray,
                    size: 45,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'My Habit',
                      style: Styles.counterTextString,
                    ),
                  ),
                ],
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '6',
                      style: Styles.counterTextNumber,
                    ),
                    Text(
                      'days',
                      style: Styles.counterTextString,
                    ),
                  ],
                ),
              ),
              MediaQuery(
                data: MediaQueryData(),
                child: Positioned(
                  bottom: 0,
                  child: Image.asset(
                    'images/chart.png',
                    width: MediaQuery.of(context).size.width / 2.5,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewHabit extends StatefulWidget {
  @override
  _NewHabitState createState() => _NewHabitState();
}

class _NewHabitState extends State<NewHabit> {
  DateTime _relapseDate;
  String _habitName;
  FocusNode _textFieldFocus = new FocusNode();
  final _habitNameController = TextEditingController();
  
  @override void dispose() {
    // TODO: implement dispose
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Choose Habit',
          style: Styles.counterTextString.copyWith(fontSize: 25),
        ),
      ),
      child: GestureDetector(
        onTap: (){
          _textFieldFocus.unfocus();
        },
        child: Container(
          decoration: Styles.backgroundGradient,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Choose a Habit and a Start Date',
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontFamily: 'SourceSans',
                                fontSize: 17,
                              ),
                            ),
                            Divider(
                              color: Colors.grey[300],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Name',
                                    style: TextStyle(fontFamily: 'SourceSans'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                              child: CupertinoTextField(
                                controller: _habitNameController,
                                focusNode: _textFieldFocus,
                                autocorrect: true,
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                keyboardAppearance: Brightness.dark,
                                placeholder: 'Drinking alcohol',
                                textAlign: TextAlign.left,
                                textCapitalization: TextCapitalization.words,
                                style: TextStyle(
                                  fontFamily: 'SourceSans',
                                  color: Colors.black87
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Last relapse date',
                                    style: TextStyle(fontFamily: 'SourceSans'),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 300,
                                    height: 100,
                                    child: CupertinoDatePicker(
                                      onDateTimeChanged: (date) {
                                        _relapseDate = date;
                                        print(_relapseDate);
                                      },
                                      initialDateTime: DateTime.now(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            CupertinoButton(
                              onPressed: () {
                                _habitName = _habitNameController.text;
                                print("$_relapseDate $_habitName");
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(CupertinoIcons.add_circled),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Text('Confirm'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
