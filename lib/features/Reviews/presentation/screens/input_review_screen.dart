import 'package:crafty_bay/features/Reviews/presentation/screens/review_screen.dart';
import 'package:flutter/material.dart';

import '../../../app/extensions/localization_extension.dart';

class InputReviewScreen extends StatefulWidget {
  const InputReviewScreen({super.key});

  static const String name='/input-review';

  @override
  State<InputReviewScreen> createState() => _InputReviewScreenState();
}

class _InputReviewScreenState extends State<InputReviewScreen> {

  final TextEditingController _firstNameTEController= TextEditingController();
  final TextEditingController _lastNameTEController= TextEditingController();
  final TextEditingController _descriptionTEController= TextEditingController();

  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme=TextTheme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Create Review'),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: .onUserInteraction,
              child: Column(
                children: [
                  SizedBox(height: 24,),
                  TextFormField(
                    controller: _firstNameTEController,
                    textInputAction: .next,
                    decoration: InputDecoration(
                      hintText: context.localization.first_name,
                      labelText: context.localization.first_name,
                    ),
                  ),
                  SizedBox(height: 12,),
                  TextFormField(
                    controller: _lastNameTEController,
                    textInputAction: .next,
                    decoration: InputDecoration(
                      hintText: context.localization.last_name,
                      labelText: context.localization.last_name,
                    ),
                  ),
                  SizedBox(height: 12,),
                  TextFormField(
                    maxLines: 6,
                    controller: _descriptionTEController,
                    decoration: InputDecoration(
                      hintText: context.localization.description,
                      labelText: context.localization.description,
                      contentPadding: .only(
                        top: 30,
                        left: 10,
                      )
                    ),
                  ),
                  SizedBox(height: 16,),
                  FilledButton(onPressed: _onTapSubmitButton, child: Text('Submit')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton(){
    Navigator.pushNamed(context, ReviewScreen.name);
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _descriptionTEController.dispose();
  }
}

