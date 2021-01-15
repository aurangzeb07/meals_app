import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings-screen';

  final Function saveSettings;
  final Map<String, bool> settingCurrent;

  SettingsScreen(this.settingCurrent , this.saveSettings);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.settingCurrent['gluten'];
    _lactoseFree = widget.settingCurrent['lactose'];
    _vegan = widget.settingCurrent['vegan'];
    _vegetarian = widget.settingCurrent['vegetarian'];
    super.initState();
  }

  Widget _buildSwitchListTile(
      bool value, String text, String subTitle, Function updateValue) {
    return SwitchListTile(
      title: Text(text),
      value: value,
      onChanged: updateValue,
      subtitle: Text(subTitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedSettings = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveSettings(selectedSettings);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust Your Meal Section.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(_glutenFree, 'Gluten-Free',
                    'Only include gluten-free meals.', (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                _buildSwitchListTile(
                    _vegetarian, 'Vegetarian', 'Only include Vegetarian meals.',
                    (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                }),
                _buildSwitchListTile(
                    _vegan, 'Vegan', 'Only include Vegan meals.', (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
                _buildSwitchListTile(_lactoseFree, 'Lactose-Free',
                    'Only include lactose-free meals.', (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
