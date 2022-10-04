import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:spike_theme_app/theme/app_theme.dart';
import 'package:spike_theme_app/theme/theme_provider.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  static const double _containerWidth = 450.0;

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.I.get<ThemeProvider>();
    return SizedBox(
      height: (_containerWidth - (17 * 2) - (10 * 2)) / 3,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 10,
        crossAxisCount: appThemes.length,
        children: List.generate(
          appThemes.length,
          (i) {
            bool isSelectedTheme = appThemes[i].mode == getIt.selectedThemeMode;
            return GestureDetector(
              onTap: isSelectedTheme
                  ? null
                  : () => getIt.setSelectedThemeMode(appThemes[i].mode),
              child: AnimatedContainer(
                height: 100,
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelectedTheme
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 2, color: Theme.of(context).primaryColor),
                ),
                child: Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).cardColor.withOpacity(0.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(appThemes[i].icon),
                        Text(
                          appThemes[i].title,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
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
