import 'package:flutter/material.dart';
import 'package:kynex/features/auth/presentation/view/register_view.dart';

void nextPage(
  BuildContext context,
  PageController pageController,
  int pageIndex,
  int lastPageIndex,
) {
  pageController.nextPage(
    duration: Duration(seconds: 1),
    curve: Curves.easeInOut,
  );
  if (pageIndex == lastPageIndex - 1) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => RegisterView()),
      (context) => false,
    );
  }
}
