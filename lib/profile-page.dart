import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Center(child: CircleAvatar(radius: 50)),
              Container(height: 10),
              Text("Connor Wilson", style: Theme.of(context).textTheme.subtitle1),
              Wrap(
                children: [
                  CustomChip(),
                  CustomChip(),
                  CustomChip(),
                  CustomChip(),
                  CustomChip(),
                  CustomChip(),
                  CustomChip(),
                  CustomChip(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomChip extends StatefulWidget {
  @override
  _CustomChipState createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
      child: FilterChip(
        showCheckmark: false,
        selected: _selected,
        label: Text("Math"), 
        onSelected: (v){setState(() => _selected = v);}
      ),
    );
  }
}