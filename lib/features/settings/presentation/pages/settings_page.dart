import 'package:finance/core/widgets/bottom_nav_bar.dart';
import 'package:finance/features/settings/presentation/widgets/section_container.dart';
import 'package:finance/features/settings/presentation/widgets/section_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SectionContainer(
            title: 'Preferences',
            items: [
              SectionItem(
                icon: FontAwesomeIcons.moneyBill1,
                title: 'Currency',
                subtitle: 'USD (\$)',
                iconColor: Colors.amber,
              ),
              Divider(height: 1, thickness: 1, indent: 16, endIndent: 16),
              SectionItem(
                icon: FontAwesomeIcons.moon,
                title: 'Theme',
                subtitle: 'Dark Mode',
                iconColor: Colors.indigo,
              ),
              Divider(height: 1, thickness: 1, indent: 16, endIndent: 16),
              SectionItem(
                icon: FontAwesomeIcons.language,
                title: 'Language',
                subtitle: 'English',
                iconColor: Colors.purple,
              ),
            ],
          ),
          SizedBox(height: 24),
          SectionContainer(
            title: 'Security',
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
            title: 'Data',
            items: [
              SectionItem(
                icon: FontAwesomeIcons.fileExport,
                title: 'Export Data',
                subtitle: '',
                iconColor: Colors.orange,
              ),
              SectionItem(
                icon: FontAwesomeIcons.cloud,
                title: 'Cloud Sync',
                subtitle: '',
                iconColor: Colors.blue,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Hero(
        tag: 'bottom_nav_bar',
        child: BottomNavBar(currentIndex: 3),
      ),
    );
  }
}
