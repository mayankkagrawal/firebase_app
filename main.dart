import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  var fsc = FirebaseFirestore.instance;
  String x;
  var data;
  myweb(cmd) async {
    print(cmd);
    var url = "http://192.168.43.143/cgi-bin/cmd.py?x=${cmd}";
    var r = await http.get(url);
    // var sc = r.statusCode;
    setState(() {
      data = r.body;
    });

    var d = fsc.collection("students").add({
      x: data,
    });

    print(data);
  }

  mybody() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.amber,
          image: DecorationImage(
           image: NetworkImage("https://www.onlogic.com/company/io-hub/wp-content/uploads/2009/01/Read-only-Linux.jpg"),
           fit: BoxFit.fill,
           )),
      child: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          height: 250,
          width: 250,
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 700,
              width: 300,
              color: Colors.transparent,
              child: Column(
                children: <Widget>[
                  Card(
                      child: TextField(
                    autocorrect: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "CHECK COMMAND ",
                        hoverColor: Colors.green,
                        prefixIcon: Icon(Icons.tablet_android)),
                    onChanged: (val) {
                      x = val;
                    },
                  )),
                  Card(
                    child: FlatButton(
                        onPressed: () {
                          myweb(x);
                        },
                        child: Text(
                          "CHECK THE OUTPUT",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )),
                  ),
                  Container(
                    height: 80,
                    width: 200,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [
                          Colors.red[900],
                          Colors.purple[600],
                          Colors.deepPurple[900],
                        ])),
                    child: Text(
                      data ?? "output is coming",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
      appBar: AppBar(
        //leading: Image.asset("https://www.onlogic.com/company/io-hub/wp-content/uploads/2009/01/Read-only-Linux.jpg"),
        actions: <Widget>[Icon(Icons.home)],
        title: Center(
          child: Text(
            "Command App",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20),
          ),
        ),
        backgroundColor: Colors.orange
      ),
      body: mybody(),
    ));
  }
}