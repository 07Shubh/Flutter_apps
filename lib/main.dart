import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Interset Calculator",
    home: SIForm(),
    theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue,
        accentColor: Colors.greenAccent),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();
  var _currencies = ['Rupees', 'Dollars', 'Pounds', 'Other'];
  final _minimumPadding = 5.0;
  var _currentValueSelected = "";
  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  var displayResult = "";

  @override
  void initState() {
    super.initState();
    _currentValueSelected = _currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: principalController,
                      validator: (String value){
                        if (value.isEmpty) {
                          return 'Please enter the Principal amount';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Principal",
                          hintText: "Enter Principal e.g. 12000",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: roiController,
                      validator: (String value){
                        if (value.isEmpty) {
                          return 'Please enter the Rate of Interest';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Rate of Interest",
                          hintText: "In percent",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: _minimumPadding, bottom: _minimumPadding),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              style: textStyle,
                              controller: termController,
                              validator: (String value){
                                if(value.isEmpty){
                                  return "Please enter the terms";
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: "Terms",
                                  hintText: "Time in Year",
                                  labelStyle: textStyle,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                            ))),
                    Container(
                      width: _minimumPadding * 5,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: _minimumPadding, bottom: _minimumPadding),
                        child: DropdownButton(
                            items: _currencies.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: _currentValueSelected,
                            onChanged: (String newValueSelected) {
                              _onDropdownItemSelected(newValueSelected);
                            }),
                      ),
                    )
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: RaisedButton(
                                color: Colors.lightBlue,
                                textColor: Colors.white,
                                child: Text(
                                  'Calculate',
                                  textScaleFactor: 1.25,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (_formKey.currentState.validate()) {
                                      this.displayResult =
                                          _calculateTotalReturns();
                                    }
                                  });
                                })),
                        Expanded(
                            child: RaisedButton(
                                color: Colors.black,
                                textColor: Colors.white,
                                child: Text(
                                  'Reset',
                                  textScaleFactor: 1.25,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _reset();
                                  });
                                }))
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.all(_minimumPadding * 2),
                    child: Text(
                      this.displayResult,
                      style: textStyle,
                    ))
              ],
            )),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/img_457211.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  void _onDropdownItemSelected(String newValueSelected) {
    setState(() {
      this._currentValueSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;
    String result =
        'After $term years, your investment will be worth $totalAmountPayable $_currentValueSelected';
    return result;
  }

  void _reset() {
    principalController.text = "";
    roiController.text = "";
    termController.text = "";
    displayResult = "";
    _currentValueSelected = _currencies[0];
  }
}
