import 'package:crafty_bay/features/shared/presentation/presentation/provider/main_nav_holder_provider.dart';
import 'package:crafty_bay/features/shared/presentation/widget/category_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/app_colors.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, _)=>_backToHome(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Category'),
          leading: IconButton(onPressed: _backToHome,
          icon: Icon(Icons.arrow_back_ios)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index){
                return FittedBox(child: CategoryCard());
              }
          ),
        )
      ),
    );
  }

  void _backToHome(){
    context.read<MainNavHolderProvider>().backToHome();
  }
}
