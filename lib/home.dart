import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:tambola/main.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentNo;
  int index;
  List<int> doneNo = new List<int>.generate(90, (i) => i + 1);
  List<int> remainNo = new List<int>.generate(90, (i) => i + 1);

  void getNo() {
    if (remainNo.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Game Over!!!"),
          content: Text("Want to play again?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () => RestartWidget.restartApp(context),
              child: Text("Yes"),
            ),
            FlatButton(
              onPressed: () => SystemNavigator.pop(),
              child: Text("No"),
            ),
          ],
        ),
        barrierDismissible: false,
      );
    } else {
      setState(() {
        currentNo = remainNo[new Random().nextInt(remainNo.length)];
        remainNo.remove(currentNo);
        doneNo[currentNo - 1] = -1;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Number Picker"),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            child: Text("Reset"),
            onPressed: () => RestartWidget.restartApp(context),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  currentNo == null ? 'Start' : currentNo.toString(),
                  style: TextStyle(fontSize: 75.0),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                padding: EdgeInsets.all(5),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
                ),
                itemBuilder: (BuildContext context, index) {
                  return Card(
                    color: doneNo[index] == -1 ? Colors.blue : Colors.white,
                    elevation: 1,
                    child: Align(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 17.5,
                          color:
                              doneNo[index] == -1 ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: doneNo.length,
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: RaisedButton(
                onPressed: () {
                  getNo();
                },
                child: Text(
                  currentNo == null ? "Start" : "Next",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.blue,
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 50)),
          ],
        ),
      ),
    );
  }
}
