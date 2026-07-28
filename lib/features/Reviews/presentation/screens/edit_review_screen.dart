import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/extensions/localization_extension.dart';
import '../../../shared/presentation/widget/centered_progress_indicator.dart';
import '../../../shared/presentation/widget/snack_bar_message.dart';
import '../../../shared/presentation/utils/validators.dart';
import '../../data/models/update_review_params.dart';
import '../provider/update_review_provider.dart';

class EditReviewScreen extends StatefulWidget {
  const EditReviewScreen({
    super.key,
    required this.reviewId,
    required this.currentRating,
    required this.currentComment,
  });

  final String reviewId;
  final int currentRating;
  final String currentComment;

  static const String name = '/edit-review';

  @override
  State<EditReviewScreen> createState() => _EditReviewScreenState();
}

class _EditReviewScreenState extends State<EditReviewScreen> {

  final TextEditingController _commentTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UpdateReviewProvider _updateReviewProvider = UpdateReviewProvider();

  late int _selectedRating;

  @override
  void initState() {
    super.initState();
    _selectedRating = widget.currentRating;
    _commentTEController.text = widget.currentComment;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _updateReviewProvider,
      child: Scaffold(
        appBar: AppBar(title: Text(context.localization.editReview),),
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
                    Text(context.localization.yourRating, style: TextStyle(fontWeight: .w500)),
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
                        hintText: context.localization.writeYourReview,
                        labelText: context.localization.reviews,
                      ),
                      validator: (input)=> Validators.validateInput(input, 'Please write a review'),
                    ),
                    SizedBox(height: 16,),
                    Consumer<UpdateReviewProvider>(
                        builder: (context, updateReviewProvider, _) {
                          if(updateReviewProvider.isLoading){
                            return CenteredProgressIndicator();
                          }
                          return SizedBox(
                            width: double.infinity,
                            child: FilledButton(onPressed: _onTapUpdateButton, child: Text(context.localization.update)),
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

  Future<void> _onTapUpdateButton()async{
    if(_formKey.currentState!.validate() == false) return;

    UpdateReviewParams params = UpdateReviewParams(
      rating: _selectedRating,
      comment: _commentTEController.text.trim(),
    );

    final bool isSuccess = await _updateReviewProvider.updateReview(widget.reviewId, params);
    if(isSuccess && mounted){
      Navigator.pop(context, true);
    }else if(mounted){
      showSnackBarMessage(context, _updateReviewProvider.errorMessage!);
    }
  }

  @override
  void dispose() {
    _commentTEController.dispose();
    super.dispose();
  }
}