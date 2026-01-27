import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:ice_shield/ui_layer/home_page/MainButton.dart';

class FinancePage extends StatelessWidget {
  const FinancePage({super.key});

  static Widget icon(BuildContext context, {double? size}) {
    return MainButton(
      type: "finance",
      destination: "/finance",
      size: size,
      icon: Icons.add,
      mainFunction: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: AutoSizeText(
              'Add Transaction feature coming soon!',
              maxLines: 1,
            ),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: AutoSizeText(
          'Finance',
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_balance_wallet,
                size: 80,
                color: Colors.blue.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 24),
              AutoSizeText(
                'Finance Module',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 12),
              AutoSizeText(
                'Coming Soon',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 24),
              AutoSizeText(
                'Track your budget, expenses, and financial goals',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                maxLines: 2,
                minFontSize: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
