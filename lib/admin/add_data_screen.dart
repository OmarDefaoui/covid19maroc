import 'package:covid19morocco/admin/add_data_service.dart';
import 'package:covid19morocco/admin/auth_service.dart';
import 'package:covid19morocco/admin/login_screen.dart';
import 'package:covid19morocco/models/model_city.dart';
import 'package:covid19morocco/models/model_data.dart';
import 'package:covid19morocco/models/model_region.dart';
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
    ModelRegion(name: 'Casa Settat​ : الدار البيضاء سطات', cities: []),
    ModelRegion(name: 'Marrakech Safi : مراكش أسفي', cities: []),
    ModelRegion(name: 'Fès Meknès : فاس مكناس', cities: []),
    ModelRegion(
        name: 'Tanger Tétouan Al-Hoceïma : طنجة تطوان الحسيمة', cities: []),
    ModelRegion(name: 'Rabat Salé Kénitra​ : الرباط سلا القنيطرة', cities: []),
    ModelRegion(name: 'Beni-Mellal Khénifra​​ : بني ملال خنيفرة', cities: []),
    ModelRegion(name: 'Drâa Tafilalet : درعة تافيلالت', cities: []),
    ModelRegion(name: 'Oriental : الشرق', cities: []),
    ModelRegion(name: 'Souss Massa : سوس ماسة', cities: []),
    ModelRegion(name: 'Dakhla Oued-Ed-Dahab : الداخلة وادي الذهب', cities: []),
    ModelRegion(name: 'Guelmim Oued-Noun : كلميم واد نون', cities: []),
    ModelRegion(
        name: 'Laâyoune Sakia-El-Hamra : العيون الساقية الحمراء', cities: []),
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
                          'الحالات المؤكدة',
                          'New Cases',
                          (value) => data.totalCases = value,
                          (value) => data.newCases = value),
                      twoTextField(
                          'الوفيات',
                          'New Deaths',
                          (value) => data.totalDeaths = value,
                          (value) => data.newDeaths = value),
                      twoTextField(
                          'المتعافون',
                          'New Recovred',
                          (value) => data.totalRecovred = value,
                          (value) => data.newRecovred = value),
                      twoTextField(
                          'حالات تتلقى العلاج',
                          'New Active',
                          (value) => data.totalActive = value,
                          (value) => data.newActive = value),
                      twoTextField(
                          'الحالات الحرجة',
                          'New Critical',
                          (value) => data.totalCritical = value,
                          (value) => data.newCritical = value),
                      twoTextField(
                          'حالات التنفس الاصطناعي',
                          'New ArtificialRespiration',
                          (value) => data.totalArtificialRespiration = value,
                          (value) => data.newArtificialRespiration = value),
                      twoTextField(
                          'الحالات المستبعدة',
                          'New NegatifTests',
                          (value) => data.totalTests = value,
                          (value) => data.newTests = value),

                      // Submit UI
                      SizedBox(height: _fieldDistance * 4),
                      _isPerforming
                          ? Center(child: CircularProgressIndicator())
                          : Container(
                              width: 200,
                              height: 60,
                              color: Colors.blue,
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onLongPress: _submit,
                                child: Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
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
                                  child: Row(
                                    children: [
                                      FlatButton(
                                        color: Colors.blue,
                                        onPressed: () {
                                          setState(() {
                                            region.cities.add(ModelCity());
                                          });
                                        },
                                        child: Text(
                                          'Add city',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      FlatButton(
                                        color: Colors.red,
                                        onPressed: () {
                                          setState(() {
                                            region.cities.removeLast();
                                          });
                                        },
                                        child: Text(
                                          'Remove city',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
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

      //Check if newCases in cities matches with region newCases
      //and if there the two lang for the name
      for (ModelRegion region in data.regions) {
        int total = 0;
        for (ModelCity city in region.cities) {
          total += int.parse(city.newCases);

          //check availability of two lang
          if (!city.name.contains(':')) {
            setState(() => _isPerforming = false);
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text(
                  'Please provide fr and ar name separated with : => prob in ${city.name}'),
              duration: Duration(seconds: 5),
            ));
            return;
          }
        }
        if (total != int.parse(region.newCases)) {
          setState(() => _isPerforming = false);

          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(
                'The sum of city cases doesn\'t match with region: ${region.name} newCases'),
            duration: Duration(seconds: 5),
          ));
          return;
        }
      }

      //sort data
      for (ModelRegion region in data.regions) {
        region.cities.sort(
            (a, b) => int.parse(b.newCases).compareTo(int.parse(a.newCases)));
      }
      data.regions.sort(
          (a, b) => int.parse(b.newCases).compareTo(int.parse(a.newCases)));

      // add data
      bool addSuccess = await AddDataService.addData(data);

      if (addSuccess) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => AddDataScreen()),
          (Route<dynamic> route) => false,
        );
      } else {
        setState(() => _isPerforming = false);

        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Error during adding data'),
          duration: Duration(seconds: 5),
        ));
      }
    }
  }
}
