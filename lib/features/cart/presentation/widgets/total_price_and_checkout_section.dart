import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../../../app/extensions/localization_extension.dart';
import '../providers/cart_list_provider.dart';

class TotalPriceAndCheckoutSection extends StatelessWidget {
  const TotalPriceAndCheckoutSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(16),
      decoration: BoxDecoration(
        borderRadius: .only(topLeft: .circular(8), topRight: .circular(8)),
        color: AppColors.themeColor.withAlpha(30),
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Column(
            crossAxisAlignment: .start,
            children: [
              Text(context.localization.totalPrice, style: TextStyle(fontWeight: .w600),),
              Text('${Constants.takaSign} ${NumberFormat.decimalPattern(Localizations.localeOf(context).languageCode).format(context.read<CartListProvider>().totalPrice)}',
                style: TextStyle(fontWeight: .w600,fontSize: 18,color: AppColors.themeColor),
              ),
            ],
          ),
          SizedBox(
              width: 140,
              child: FilledButton(onPressed: (){}, child: Text(context.localization.checkout))),
        ],
      ),
    );
  }
}