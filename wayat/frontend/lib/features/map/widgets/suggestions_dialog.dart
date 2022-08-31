import 'package:flutter/material.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/features/map/widgets/suggestions_tile.dart';

class SuggestionsDialog extends StatelessWidget {
  final Iterable<ContactLocation> options;
  final void Function(ContactLocation) onSelected;
  const SuggestionsDialog({
    required this.options,
    required this.onSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: AlignmentDirectional.topCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          border: Border.all(color: ColorTheme.secondaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView.builder(
              itemExtent: 45,
              itemCount: options.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => SuggestionsTile(
                    contact: options.elementAt(index),
                    onTap: () => onSelected(options.elementAt(index)),
                  )),
        ),
      ),
    );
  }
}
