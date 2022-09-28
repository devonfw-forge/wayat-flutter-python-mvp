import 'package:flutter/material.dart';
import 'package:wayat/common/widgets/loading_widget.dart';

/// Page with a loading spin inside.
class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoadingWidget(),
    );
  }
}
