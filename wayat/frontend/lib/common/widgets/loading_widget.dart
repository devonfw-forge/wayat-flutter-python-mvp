import 'package:flutter/material.dart';
import 'package:wayat/common/theme/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: const Center(
          child: CircularProgressIndicator(
        color: ColorTheme.primaryColor,
      )),
    );
  }
}
