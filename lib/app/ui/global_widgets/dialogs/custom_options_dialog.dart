import 'package:flutter/material.dart';

class CustomOptionsDialog extends StatelessWidget {
  final Function() onEdit;
  final Function() onDelete;

  const CustomOptionsDialog(
      {Key? key, required this.onEdit, required this.onDelete})
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
                onTap: onEdit,
                title: Text("Editar"),
              ),
              ListTile(
                onTap: onDelete,
                title: Text("BORRAR",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.red[700],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
