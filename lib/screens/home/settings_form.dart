import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/models/user.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user?.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  const Text(
                    'Update your brew settings',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData?.name,
                    decoration: textInputDecoration.copyWith(hintText: 'Name'),
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  const SizedBox(height: 20.0),
                  //dropdown
                  DropdownButtonFormField(
                    value: _currentSugars ?? userData?.sugars,
                    decoration: textInputDecoration,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                          value: sugar, child: Text('$sugar sugars'));
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugars = val),
                  ),
                  //slider
                  Slider(
                    value: (_currentStrength ?? userData!.strength)!.toDouble(),
                    activeColor:
                        Colors.brown[_currentStrength ?? userData!.strength!],
                    inactiveColor:
                        Colors.brown[_currentStrength ?? userData!.strength!],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                  ),
                  //button
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[400],
                      ),
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          await DatabaseService(uid: user?.uid).updateUserData(
                            _currentSugars ?? userData!.sugars!,
                            _currentName ?? userData!.name!,
                            _currentStrength ?? userData!.strength!,
                          );
                          Navigator.pop(context);
                        }
                      }),
                ],
              ),
            );
          } else {
            return const Loading();
          }
        });
  }
}
