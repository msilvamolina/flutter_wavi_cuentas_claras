import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/new_expense_controller.dart';

class CustomCheckBoxPersonsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('¿Qué personas?'),
      content: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: EdgeInsets.all(0),
          child: GetBuilder<NewExpenseController>(
            id: 'personDialog',
            builder: (controller) {
              return ListBody(
                children: [
                  for (var i = 0;
                      i < controller.mainController.listParticipants.length;
                      i++) ...[
                    CheckboxListTile(
                      value: controller.mapPersons[controller
                              .mainController.listParticipants[i].id] ??
                          false,
                      onChanged: (value) => controller.personDialogOnChanged(
                          controller.mainController.listParticipants[i].id,
                          value!),
                      title: Text(
                          controller.mainController.listParticipants[i].name +
                              (controller.mainController.listParticipants[i]
                                          .amountPersons >
                                      1
                                  ? ' (' +
                                      controller.mainController
                                          .listParticipants[i].amountPersons
                                          .toString() +
                                      ')'
                                  : '')),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ],
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: controller.addPersonFromDialog,
                    child: Text('NUEVA PERSONA'),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: controller.addGroup,
                    child: Text('NUEVA GRUPO'),
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
