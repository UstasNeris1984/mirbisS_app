import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestHttp extends StatefulWidget {
  final String url;

  TestHttp({String url}):url = url;

  @override
  State<StatefulWidget> createState() => TestHttpState();
}// TestHttp

class TestHttpState extends State<TestHttp> {
  final _formKey = GlobalKey<FormState>();

  String _url, _body;
  int _status;

  @override
  void initState() {
    _url = widget.url;
    super.initState();
  }//initState

  _sendRequestGet() {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();//update form data

      http.get(_url).then((response){
        _status = response.statusCode;
        _body = response.body;

        setState(() {});//reBuildWidget
      }).catchError((error){
        _status = 0;
        _body = error.toString();

        setState(() {});//reBuildWidget
      });
    }
  }//_sendRequestGet

  _sendRequestPost() async {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();//update form data

      try {
        var response = await http.post(_url);

        _status = response.statusCode;
        _body = response.body;
      } catch (error) {
        _status = 0;
        _body = error.toString();
      }
      setState(() {});//reBuildWidget
    }
  }//_sendRequestPost

  _sendRequestPostBodyHeaders() async {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();//update form data

      try {
        var response = await http.post(_url,
            body: {'name':'test','num':'10'},
            headers: {'Accept':'application/json'}
        );

        _status = response.statusCode;
        _body = response.body;
      } catch (error) {
        _status = 0;
        _body = error.toString();
      }
      setState(() {});//reBuildWidget
    }
  }//_sendRequestPost


  Widget build(BuildContext context) {
    return Form(key: _formKey, child: SingleChildScrollView(child: Column(
      children: <Widget>[
        Container(
            child: Text('MyApp_for_http_api', style: TextStyle(fontSize: 25.0,color: Colors.red)),
            padding: EdgeInsets.all(10.0)
        ),
        Container(
            child: TextFormField(initialValue: _url, validator: (value){if (value.isEmpty) return 'API url isEmpty';}, onSaved: (value){_url = value;}, autovalidate: true),
            padding: EdgeInsets.all(10.0)
        ),
        SizedBox(height: 20.0),
        RaisedButton(child: Text('GET'), onPressed: _sendRequestGet),
        SizedBox(height: 20.0),
        Text('Response status', style: TextStyle(fontSize: 25.0,color: Colors.red)),
        Text(_status == null ? '' :_status.toString()),
        SizedBox(height: 20.0),
        Text('Response body', style: TextStyle(fontSize: 25.0,color: Colors.red)),
        Text(_body == null ? '' : _body),
      ],
    )));
  }//build
}//TestHttpState

class MirbisApp extends StatelessWidget {
  @override
  MirbisApp CodeScreen()=> MirbisApp();
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text('HTTP_API_ver_1.1'),
          actions: <Widget>[IconButton(icon: Icon(Icons.code), tooltip: 'Code', onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => CodeScreen()));
          })],
        ),
        body: TestHttp(url: 'https://alexwohlbruck.github.io/cat-facts/')
    );
  }
}

void main() => runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MirbisApp()
    )
);

class TextWidget extends  StatelessWidget  {
  @override
  TextWidget ProfilePage()=> TextWidget();
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              'Hello, World!',
              style: TextStyle( color: Colors.blue, fontSize: 32.0,  decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dotted,),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top:20.0),
            child: FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              textColor: Theme.of(context).primaryColor,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Colors.blue,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 34.0, vertical: 12.0),
                child: Text("Touch me",  style: TextStyle( color: Colors.white, fontSize: 22.0,) ),
              ),
            ),
          )
        ]
    );
  }
}