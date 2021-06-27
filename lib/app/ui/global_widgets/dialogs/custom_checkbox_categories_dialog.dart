import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/calculate_controller.dart';
import '../../../data/models/person/person.dart';

class CustomCheckBoxDialog extends StatelessWidget {
  final Person person;

  const CustomCheckBoxDialog({Key? key, required this.person})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('¿Qué categorías pagará ${person.name}?'),
      content: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: EdgeInsets.all(0),
          child: GetBuilder<CalculateController>(
            id: 'personDialog',
            builder: (controller) {
              Map<String, bool> personCategories =
                  controller.mapPersonsCategories[person.id];

              return ListBody(
                children: [
                  for (var i = 0;
                      i < controller.mainController.listCategories.length;
                      i++) ...[
                    CheckboxListTile(
                      value: personCategories[
                          controller.mainController.listCategories[i].id],
                      onChanged: (value) => controller.personDialogOnChanged(
                          value!,
                          person,
                          controller.mainController.listCategories[i].id),
                      title: Text(
                          controller.mainController.listCategories[i].name),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ],
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {},
                    child: Text('NUEVA CATEGORIA'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
