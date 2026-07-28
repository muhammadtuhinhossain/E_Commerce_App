import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/extensions/localization_extension.dart';
import '../../../shared/presentation/utils/validators.dart';
import '../../../shared/presentation/widget/centered_progress_indicator.dart';
import '../../../shared/presentation/widget/snack_bar_message.dart';
import '../../data/models/add_review_params.dart';
import '../provider/add_review_provider.dart';

class InputReviewScreen extends StatefulWidget {
  const InputReviewScreen({super.key, required this.productId});

  final String productId;

  static const String name='/input-review';

  @override
  State<InputReviewScreen> createState() => _InputReviewScreenState();
}

class _InputReviewScreenState extends State<InputReviewScreen> {

  final TextEditingController _commentTEController= TextEditingController();
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  final AddReviewProvider _addReviewProvider = AddReviewProvider();

  int _selectedRating = 5;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _addReviewProvider,
      child: Scaffold(
        appBar: AppBar(title: Text(context.localization.createReview),),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: .onUserInteraction,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    SizedBox(height: 12,),
                    Text('Your Rating', style: TextStyle(fontWeight: .w500)),
                    SizedBox(height: 4,),
                    Row(
                      children: List.generate(5, (index){
                        return IconButton(
                          onPressed: (){
                            setState(() {
                              _selectedRating = index + 1;
                            });
                          },
                          icon: Icon(
                            index < _selectedRating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 32,
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 8,),
                    TextFormField(
                      maxLines: 6,
                      controller: _commentTEController,
                      decoration: InputDecoration(
                        hintText: 'Write your review',
                        labelText: 'Review',
                      ),
                      validator: (input)=> Validators.validateInput(input, 'Please write a review'),
                    ),
                    SizedBox(height: 16,),
                    Consumer<AddReviewProvider>(
                        builder: (context,addReviewProvider,_) {
                          if(addReviewProvider.isLoading){
                            return CenteredProgressIndicator();
                          }
                          return SizedBox(
                            width: double.infinity,
                            child: FilledButton(onPressed: _onTapSubmitButton, child: Text(context.localization.submit)),
                          );
                        }
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapSubmitButton()async{
    if(_formKey.currentState!.validate() == false) return;

    AddReviewParams params = AddReviewParams(
      productId: widget.productId,
      rating: _selectedRating,
      comment: _commentTEController.text.trim(),
    );

    final bool isSuccess = await _addReviewProvider.addReview(params);
    if(isSuccess && mounted){
      Navigator.pop(context, true);
    }else if(mounted){
      showSnackBarMessage(context, _addReviewProvider.errorMessage!);
    }
  }

  @override
  void dispose() {
    _commentTEController.dispose();
    super.dispose();
  }
}