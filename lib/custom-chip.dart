import 'package:flutter/material.dart';

class CustomChip extends StatefulWidget {
  CustomChip({@required this.onChanged, @required this.title, this.selected});
  final String title;
  final Function onChanged;
  final bool selected;

  @override
  _CustomChipState createState() => _CustomChipState(onChanged, title, selected ?? false);
}

class _CustomChipState extends State<CustomChip> {
  _CustomChipState(this.onChanged, this.title, this.selected);
  bool selected = false;
  final String title;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
      child: FilterChip(
        selectedColor: Colors.deepPurple,
        backgroundColor: Color.fromRGBO(16, 20, 25, 1),
        labelStyle: TextStyle(
          color: selected ? Colors.black : Colors.white
        ),
        selected: selected,
        label: Text(title), 
        onSelected: (v){
          setState(() => selected = v);
          this.onChanged(v);
        }
      ),
    );
  }
}