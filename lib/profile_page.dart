import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage> {
  Set<String> _gender = <String>{
    'Male',
    'Female',
  };
  String _selectedMaterial = '';

  String weightSelected;
  String goalSelected;

  @override
  Widget build(BuildContext context) {
    final List<Widget> choiceChips = _gender.map<Widget>((String name) {
      return ChoiceChip(
        key: ValueKey<String>(name),
        backgroundColor: _nameToColor(name),
        label: Text(_capitalize(name)),
        selected: _selectedMaterial == name,
        onSelected: (bool value) {
          setState(() {
            _selectedMaterial = value ? name : '';
          });
        },
      );
    }).toList();

    final List<Widget> weights = List.generate(100, (i) => Text('$i kg'));
    final List<Widget> goals = List.generate(100, (i) => Text('${i * 100} ml'));

    return Scaffold(
      appBar: AppBar(
        elevation: 0.toDouble(),
        title: Text('Profile'),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: _buildProfilePage(weights, goals),
      ),
    );
  }

  _buildProfilePage(List<Widget> weights, List<Widget> goals) {
    return Container(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Unit of mesure'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                OutlineButton(
                  onPressed: () {},
                  child: Text("kg | ml"),
                ),
                SizedBox(width: 4.0,),
                OutlineButton(
                  onPressed: () {},
                  child: Text("lb | oz"),
                )
              ],
            ),
          ),
          ListTile(
            title: Text('Gender'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                OutlineButton(
                  onPressed: () {},
                  child: Text("Male"),
                ),
                SizedBox(width: 4.0,),
                OutlineButton(
                  onPressed: () {},
                  child: Text("Female"),
                )
              ],
            ),
          ),
          ListTile(
            title: Text('Weight'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('${weightSelected ?? ''} kg'),
                Icon(Icons.navigate_next)
              ],
            ),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext builder) {
                    return Container(
                        height:
                            MediaQuery.of(context).copyWith().size.height / 5,
                        child: CupertinoPicker(
                          onSelectedItemChanged: (int value) {
                            setState(() {
                              weightSelected = '$value';
                            });
                          },
                          itemExtent: 40.0,
                          children: weights,
                        ));
                  });
            },
          ),
          ListTile(
            title: Text('Goal'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('${goalSelected ?? ''} ml'),
                Icon(Icons.navigate_next),
              ],
            ),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext builder) {
                    return Container(
                        height:
                            MediaQuery.of(context).copyWith().size.height / 5,
                        child: CupertinoPicker(
                          onSelectedItemChanged: (int value) {
                            setState(() {
                              goalSelected = '$value';
                            });
                          },
                          itemExtent: 40.0,
                          children: goals,
                        ));
                  });
            },
          ),
        ],
      ),
    );
  }

  Color _nameToColor(String name) {
    assert(name.length > 1);
    final int hash = name.hashCode & 0xffff;
    final double hue = (360.0 * hash / (1 << 15)) % 360.0;
    return HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
  }

  String _capitalize(String name) {
    assert(name != null && name.isNotEmpty);
    return name.substring(0, 1).toUpperCase() + name.substring(1);
  }
}

class _ChipsTile extends StatelessWidget {
  const _ChipsTile({
    Key key,
    this.label,
    this.children,
  }) : super(key: key);

  final String label;
  final List<Widget> children;

  // Wraps a list of chips into a ListTile for display as a section in the demo.
  @override
  Widget build(BuildContext context) {
    final List<Widget> cardChildren = <Widget>[
      Container(
        padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
        alignment: Alignment.center,
        child: Text(label, textAlign: TextAlign.start),
      ),
    ];
    if (children.isNotEmpty) {
      cardChildren.add(Wrap(
          children: children.map<Widget>((Widget chip) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: chip,
        );
      }).toList()));
    } else {
      final TextStyle textStyle = Theme.of(context)
          .textTheme
          .caption
          .copyWith(fontStyle: FontStyle.italic);
      cardChildren.add(Semantics(
        container: true,
        child: Container(
          alignment: Alignment.center,
          constraints: const BoxConstraints(minWidth: 48.0, minHeight: 48.0),
          padding: const EdgeInsets.all(8.0),
          child: Text('None', style: textStyle),
        ),
      ));
    }

    return Card(
      semanticContainer: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: cardChildren,
      ),
    );
  }
}
