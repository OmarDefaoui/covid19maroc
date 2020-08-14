import 'package:covid19morocco/admin/add_data_service.dart';
import 'package:covid19morocco/admin/auth_service.dart';
import 'package:covid19morocco/admin/login_screen.dart';
import 'package:covid19morocco/models/model_city.dart';
import 'package:covid19morocco/models/model_data.dart';
import 'package:covid19morocco/models/model_region.dart';
import 'package:covid19morocco/screens/home_screen.dart';
import 'package:flutter/material.dart';

class AddDataScreen extends StatefulWidget {
  AddDataScreen({Key key}) : super(key: key);

  @override
  _AddDataScreenState createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  ModelData data = ModelData(regions: [
    ModelRegion(name: 'region1', cities: []),
    ModelRegion(name: 'region2', cities: []),
    ModelRegion(name: 'region3', cities: []),
    ModelRegion(name: 'region4', cities: []),
  ]);
  bool _isPerforming = false;

  final InputBorder _inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(25.0),
    borderSide: BorderSide(),
  );
  final InputBorder _enabledInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30.0),
    borderSide: BorderSide(color: Colors.deepOrange),
  );
  final double _fieldDistance = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: FlatButton(
          color: Colors.red,
          onPressed: () {
            AuthService.signOut();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen()),
              (Route<dynamic> route) => false,
            );
          },
          child: Text('Sign out'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Row(
            children: [
              // Basic data
              Flexible(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: 'Date',
                          border: _inputBorder,
                          enabledBorder: _enabledInputBorder,
                        ),
                        initialValue: '${DateTime.now()}',
                        validator: (value) => (value.trim().length < 4)
                            ? 'Must be at least 4 characters'
                            : null,
                        keyboardType: TextInputType.text,
                        onSaved: (input) => data.date = input.trim(),
                      ),
                      SizedBox(height: _fieldDistance),
                      twoTextField(
                          'totalCases',
                          'newCases',
                          (value) => data.totalCases = value,
                          (value) => data.newCases = value),
                      twoTextField(
                          'totalDeaths',
                          'newDeaths',
                          (value) => data.totalDeaths = value,
                          (value) => data.newDeaths = value),
                      twoTextField(
                          'totalRecovred',
                          'newRecovred',
                          (value) => data.totalRecovred = value,
                          (value) => data.newRecovred = value),
                      twoTextField(
                          'totalActive',
                          'newActive',
                          (value) => data.totalActive = value,
                          (value) => data.newActive = value),
                      twoTextField(
                          'totalCritical',
                          'newCritical',
                          (value) => data.totalCritical = value,
                          (value) => data.newCritical = value),
                      twoTextField(
                          'totalNegatifTests',
                          'newNegatifTests',
                          (value) => data.totalTests = value,
                          (value) => data.newTests = value),

                      // Submit UI
                      SizedBox(height: _fieldDistance * 4),
                      _isPerforming
                          ? Center(child: CircularProgressIndicator())
                          : FlatButton(
                              color: Colors.blue,
                              onPressed: _submit,
                              child: Text('Submit'),
                            ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 30),

              // Regions Data
              Flexible(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: data.regions
                        .asMap()
                        .map(
                          (index, region) => MapEntry(
                            index,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(region.name),
                                SizedBox(height: 10),
                                twoTextField(
                                    'totalCases',
                                    'newCases',
                                    (value) => region.totalCases = value,
                                    (value) => region.newCases = value),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    children: region.cities
                                        .asMap()
                                        .map(
                                          (index, city) => MapEntry(
                                            index,
                                            twoTextField(
                                                'Name',
                                                'newCases',
                                                (value) => city.name = value,
                                                (value) =>
                                                    city.newCases = value),
                                          ),
                                        )
                                        .values
                                        .toList(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: FlatButton(
                                    color: Colors.blue,
                                    onPressed: () {
                                      setState(() {
                                        region.cities.add(ModelCity());
                                      });
                                    },
                                    child: Text('Add city'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .values
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget twoTextField(String txt1, String txt2, Function(String) totalC,
          Function(String) newC) =>
      Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: txt1,
                    border: _inputBorder,
                    enabledBorder: _enabledInputBorder,
                  ),
                  validator: (value) => (value.trim().length == 0)
                      ? 'Must be at least 1 character'
                      : null,
                  keyboardType: TextInputType.number,
                  onSaved: (input) => totalC(input.trim()),
                ),
              ),
              SizedBox(width: _fieldDistance),
              Flexible(
                flex: 1,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: txt2,
                    border: _inputBorder,
                    enabledBorder: _enabledInputBorder,
                  ),
                  validator: (value) => (value.trim().length == 0)
                      ? 'Must be at least 1 character'
                      : null,
                  keyboardType: TextInputType.number,
                  onSaved: (input) => newC(input.trim()),
                ),
              ),
            ],
          ),
          SizedBox(height: _fieldDistance),
        ],
      );

  void _submit() async {
    FocusScope.of(context).requestFocus(FocusNode()); //hide keyboard
    if (_formKey.currentState.validate() && !_isPerforming) {
      _formKey.currentState.save();
      setState(() {
        _isPerforming = true;
      });

      // add data
      bool addSuccess = await AddDataService.addData(data);

      if (addSuccess) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
          (Route<dynamic> route) => false,
        );
      } else {
        setState(() => _isPerforming = false);

        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Error during adding data'),
          duration: Duration(seconds: 3),
        ));
      }
    }
  }
}
