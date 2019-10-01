import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter FireStore Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('post').snapshots(),
        builder:(context,snapshot){
          if(!snapshot.hasData){
            const Text('กำลังโหลดข้อมูล...');
          }else{
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder:(context,index){
                  DocumentSnapshot mypost = snapshot.data.documents[index];
                  return Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 350,
                            child: Padding(
                              padding: EdgeInsets.only(top: 8,bottom: 8),
                              child: Material(
                                color: Colors.white,
                                elevation: 14,
                                shadowColor: Color(0x802196F3),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 200,
                                          child: Image.network('${mypost['image']}', fit: BoxFit.fill,),
                                        ),
                                        SizedBox(height: 10,),
                                        Text('${mypost['title']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                        SizedBox(height: 10,),
                                        Text('${mypost['subtitle']}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey), overflow: TextOverflow.ellipsis,),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height *.47,
                          left: MediaQuery.of(context).size.height *.52,
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: CircleAvatar(
                            backgroundColor: Color(0xff543B7A),
                            child: Icon(Icons.star, color: Colors.white, size: 20,),
                          ),
                        ),
                      )
                    ],
                  );
                }
            );
          }
        },
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
