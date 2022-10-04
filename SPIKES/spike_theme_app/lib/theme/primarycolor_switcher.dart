import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:spike_theme_app/theme/app_colors.dart';
import 'package:spike_theme_app/theme/theme_provider.dart';

class PrimaryColorSwitcher extends StatelessWidget {
  const PrimaryColorSwitcher({super.key});

  static const double _containerWidth = 450.0;

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.I.get<ThemeProvider>();
    return SizedBox(
      height: (_containerWidth - (17 * 2) - (10 * 2)) / 3,
      child: GridView.count(
        crossAxisCount: AppColors.primaryColors.length,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 10,
        children: List.generate(
          AppColors.primaryColors.length,
          (i) {
            bool isSelectedColor =
                AppColors.primaryColors[i] == getIt.selectedPrimaryColor;
            return GestureDetector(
              onTap: isSelectedColor
                  ? null
                  : () =>
                      getIt.setSelectedPrimaryColor(AppColors.primaryColors[i]),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primaryColors[i],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isSelectedColor ? 1 : 0,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Theme.of(context).cardColor.withOpacity(0.5),
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
