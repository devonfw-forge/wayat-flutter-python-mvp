import 'package:flutter/material.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/lang/app_localizations.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  const SearchBar(
      {required this.controller, this.onChanged, this.focusNode, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      padding: const EdgeInsets.only(left: 15.0, right: 10.0),
      height: 60,
      child: TextField(
        focusNode: focusNode,
        onChanged: onChanged,
        controller: controller,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            labelText: appLocalizations.search,
            contentPadding: EdgeInsets.zero,
            floatingLabelStyle:
                const TextStyle(color: Colors.black, fontSize: 20),
            labelStyle: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
                fontSize: 18),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.black54,
            ),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide:
                    BorderSide(width: 2, color: ColorTheme.secondaryColor)),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 1, color: Colors.black))),
      ),
    );
  }
}
