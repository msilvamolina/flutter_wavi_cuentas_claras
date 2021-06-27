import 'package:flutter/material.dart';

class CustomGroupOptionsDialog extends StatelessWidget {
  final Function() onAddPerson;
  final Function() onAddGroup;

  const CustomGroupOptionsDialog(
      {Key? key, required this.onAddPerson, required this.onAddGroup})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Elegí una opción'),
      content: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: EdgeInsets.all(0),
          child: ListBody(
            children: [
              ListTile(
                onTap: onAddPerson,
                title: Text("Agregar persona"),
              ),
              ListTile(
                onTap: onAddGroup,
                title: Text("Agregar grupo"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
