import 'package:flutter/material.dart';
import 'package:phone_input_text_field/phone_input_text_field.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone Input TextField Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Phone Input TextField Example'),
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
  String _phoneNum = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:Column(
          children: <Widget>[
            Text(
              'Phone Number Entered',
            ),
            Text(
              '$_phoneNum',
              style: Theme.of(context).textTheme.display1,
            ),
            PhoneInputTextField(onPhoneNumComplete: (String phoneNum) {
              setState(() {
                _phoneNum = phoneNum;
              });
            },)
          ],
        ),
    );
  }
}
