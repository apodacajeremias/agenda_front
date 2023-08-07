import 'package:agenda_front/ui/buttons/link_text.dart';
import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  final String title;
  final String? backText;
  const FormHeader({super.key, required this.title, this.backText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        LinkText(
            text: backText ?? 'Volver',
            onPressed: () => Navigator.of(context).pop())
      ],
    );
  }
}
