import 'package:flutter/material.dart';

import 'package:spray_walls/custom_theme.dart';
import 'package:spray_walls/models/boulder.dart';
import 'package:spray_walls/services/boulder_services.dart';
import 'package:spray_walls/services/user_services.dart';

class BoulderForm extends StatefulWidget {
  Boulder? boulder;
  final String state;
  BoulderForm({super.key, required this.state, this.boulder});

  @override
  State<BoulderForm> createState() => _BoulderFormState();
}

class _BoulderFormState extends State<BoulderForm> {
  final theme = CustomTheme();
  final userServices = UserServices();
  final boulderServices = BoulderServices();

  final formKey = GlobalKey<FormState>();
  final nameKey = GlobalKey<FormState>();
  final descriptionKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  late String name = '';
  String description = '';
  bool private = true;

  @override
  void initState() {
    if (widget.state == "update") {
      _nameController.text = widget.boulder!.name;
      _descriptionController.text = widget.boulder!.description;
      private = widget.boulder!.private;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: formBody(context),
        ));
  }

  Widget formBody(BuildContext context) {
    return Column(
      children: [
        nameFormField(),
        descriptionFormField(),
        isPrivateSwitch(),
        saveButton(context),
      ],
    );
  }

  Widget nameFormField() {
    return Form(
        key: nameKey,
        child: TextFormField(
          controller: _nameController,
          cursorColor: theme.accentHighlightColor,
          decoration: theme.textFormDecoration('Boulder Name'),
          textCapitalization: TextCapitalization.sentences,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          onSaved: (value) {
            if (value != null) {
              name = value;
            }
          },
          onFieldSubmitted: (value) => saveBoulderName(),
          validator: (value) {
            var val = value;
            if (val != null) {
              if (val.isEmpty) {
                return 'Please enter a name';
              } else {
                return null;
              }
            }
            return null;
          },
        ));
  }

  void saveBoulderName() {
    var currState = nameKey.currentState;
    if (currState != null) {
      if (currState.validate()) {
        currState.save();
        setState(() {});
      }
    }
  }

  Widget descriptionFormField() {
    return TextFormField(
      key: descriptionKey,
      controller: _descriptionController,
      cursorColor: theme.accentHighlightColor,
      decoration: theme.textFormDecoration('Description'),
      textCapitalization: TextCapitalization.words,
      onSaved: (value) {
        if (value != null) {
          description = value;
        }
      },
      onFieldSubmitted: (value) => saveBoulderDescription(),
    );
  }

  void saveBoulderDescription() {
    var currState = nameKey.currentState;
    if (currState != null) {
      if (currState.validate()) {
        currState.save();
        setState(() {});
      }
    }
  }

  Widget isPrivateSwitch() {
    return Row(
      children: [
        const Text("Make Private"),
        Switch(
          value: private,
          activeColor: theme.accentHighlightColor,
          onChanged: (bool value) {
            setState(() {
              private = value;
            });
          },
        ),
      ],
    );
  }

  Widget saveButton(BuildContext context) {
    return TextButton(
        onPressed: () async {
          var currState = formKey.currentState;
          var nameState = nameKey.currentState;
          if (currState != null && nameState != null) {
            if (currState.validate() && nameState.validate()) {
              nameState.save();
              currState.save();

              await createOrUpdateBoulder();

              if (context.mounted) {
                Navigator.of(context).pop();
              }
            }
          }
        },
        child: const Text("Save"));
  }

  Future<void> createOrUpdateBoulder() async {
    if (widget.state == "create") {
      var user = await userServices.getUsername();
      // TODO: There's some hardcoded values here

      Boulder boulder = Boulder.create(
        name,
        [],
        description,
        user,
        'Andrews',
        private,
      );
      await boulderServices.addBoulder(boulder);
    } else if (widget.state == "update") {
      Boulder boulder = widget.boulder!.update(
        name,
        [],
        description,
        private,
      );
      await boulderServices.updateBoulder(boulder);
    } else {
      throw 'Boulder form state must be create or update!';
    }
  }
}
