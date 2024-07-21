import 'package:flutter/material.dart';
import 'localization.dart';

class LanguageSelector extends StatelessWidget {
  final String currentLanguageCode;
  final Function(String) onLanguageChange;

  const LanguageSelector({
    Key? key,
    required this.currentLanguageCode,
    required this.onLanguageChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);

    return Row(
      children: [
        const CircleAvatar(
          radius: 20,
          child: Icon(Icons.language_sharp),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations!.translate('language_options'),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                localizations.translate('select_language'),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        DropdownButton<String>(
          value: currentLanguageCode,
          items: const [
            DropdownMenuItem(
              value: 'en',
              child: Text('English'),
            ),
            DropdownMenuItem(
              value: 'tr',
              child: Text('Türkçe'),
            ),
            DropdownMenuItem(
              value: 'de',
              child: Text('Deutsch'),
            ),
          ],
          onChanged: (String? newValue) {
            if (newValue != null) {
              onLanguageChange(newValue);
            }
          },
        ),
      ],
    );
  }
}
