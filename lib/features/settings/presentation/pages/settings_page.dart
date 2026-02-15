import 'package:finance/core/constants/hero_tags.dart';
import 'package:finance/core/util/currencies.dart';
import 'package:finance/core/util/extensions.dart';
import 'package:finance/core/widgets/bottom_nav_bar.dart';
import 'package:finance/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:finance/features/settings/presentation/bloc/settings_event.dart';
import 'package:finance/features/settings/presentation/bloc/settings_state.dart';
import 'package:finance/features/settings/presentation/widgets/section_container.dart';
import 'package:finance/features/settings/presentation/widgets/section_item.dart';
import 'package:finance/features/settings/presentation/widgets/section_item_dropdown.dart';
import 'package:finance/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.translate.settingsTitle)),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (BuildContext context, SettingsState state) {
          return ListView(
            children: [
              SectionContainer(
                title: context.translate.settingsPreferences,
                items: [
                  SectionItemDropdown<String>(
                    icon: FontAwesomeIcons.moneyBill1,
                    title: context.translate.settingsCurrency,
                    iconColor: Colors.amber,
                    value: state.settings?.currency ?? 'USD',
                    items: Currencies.list.map((currency) {
                      return DropdownMenuItem(
                        value: currency,
                        child: Text(
                          currency,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? currency) {
                      if (currency != null) {
                        context.read<SettingsBloc>().add(
                          ChangeCurrencyEvent(currency),
                        );
                      }
                    },
                  ),
                  Divider(height: 1, thickness: 1, indent: 16, endIndent: 16),
                  SectionItemDropdown<ThemeMode>(
                    icon: FontAwesomeIcons.moon,
                    title: context.translate.settingsTheme,
                    iconColor: Colors.indigo,
                    value: state.settings!.themeMode,
                    items: ThemeMode.values.map((mode) {
                      return DropdownMenuItem(
                        value: mode,
                        child: Text(
                          mode.localize(context).capitalize(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (ThemeMode? mode) {
                      if (mode != null) {
                        context.read<SettingsBloc>().add(
                          ChangeThemeEvent(mode),
                        );
                      }
                    },
                  ),
                  Divider(height: 1, thickness: 1, indent: 16, endIndent: 16),
                  SectionItemDropdown<String>(
                    icon: FontAwesomeIcons.language,
                    title: context.translate.settingsLanguage,
                    iconColor: Colors.purple,
                    value: state.settings?.locale ?? 'en',
                    items: AppLocalizations.supportedLocales.map((locale) {
                      return DropdownMenuItem(
                        value: locale.languageCode,
                        child: Text(
                          locale.languageName,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? locale) {
                      if (locale != null) {
                        context.read<SettingsBloc>().add(
                          SaveSettingsEvent(
                            state.settings!.copyWith(locale: locale),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 24),
              SectionContainer(
                title: context.translate.settingsSecurity,
                items: [
                  SectionItem(
                    icon: FontAwesomeIcons.fingerprint,
                    title: 'Face ID & Touch ID',
                    subtitle: '',
                    iconColor: Colors.green,
                  ),
                  Divider(height: 1, thickness: 1, indent: 16, endIndent: 16),
                  SectionItem(
                    icon: FontAwesomeIcons.lock,
                    title: 'PIN',
                    subtitle: '',
                    iconColor: Colors.red,
                  ),
                ],
              ),
              SizedBox(height: 24),
              SectionContainer(
                title: context.translate.settingsData,
                items: [
                  SectionItem(
                    icon: FontAwesomeIcons.fileExport,
                    title: context.translate.settingsExportData,
                    subtitle: '',
                    iconColor: Colors.orange,
                  ),
                  SectionItem(
                    icon: FontAwesomeIcons.fileImport,
                    title: context.translate.settingsImportData,
                    subtitle: '',
                    iconColor: Colors.pink,
                  ),
                  SectionItem(
                    icon: FontAwesomeIcons.cloud,
                    title: context.translate.settingsSyncData,
                    subtitle: '',
                    iconColor: Colors.blue,
                  ),
                ],
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Hero(
        tag: HeroTags.bottomNavBar,
        child: BottomNavBar(currentIndex: 3),
      ),
    );
  }
}
