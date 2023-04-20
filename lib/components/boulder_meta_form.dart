import 'package:flutter/material.dart';

import 'package:spray_walls/custom_theme.dart';
import 'package:spray_walls/models/boulder.dart';
import 'package:spray_walls/services/boulder_services.dart';
import 'package:spray_walls/services/user_services.dart';

class BoulderMetaForm extends StatefulWidget {
  final Boulder boulder;
  final String state;
  const BoulderMetaForm({super.key, required this.state, required this.boulder});

  @override
  State<BoulderMetaForm> createState() => _BoulderMetaFormState();
}

class _BoulderMetaFormState extends State<BoulderMetaForm> {
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
  String title = '';

  @override
  void initState() {
    if (widget.state == "update") {
      title = widget.boulder.name;
      _nameController.text = widget.boulder.name;
      _descriptionController.text = widget.boulder.description;
      private = widget.boulder.private;
    } else {
      title = "New Boulder";
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: formSetup(),
    );
  }

  Widget formSetup() {
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
                Navigator.of(context).pop();
              }
            }
          }
        },
        child: const Text("Save"));
  }

  Future<void> createOrUpdateBoulder() async {
    if (widget.state == "create") {
      widget.boulder.user = await userServices.getUsername();
      widget.boulder.name = name;
      widget.boulder.description = description;
      widget.boulder.private = private;

      await boulderServices.addBoulder(widget.boulder);
    } else if (widget.state == "update") {
      Boulder boulder = widget.boulder.update(
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
