import 'package:flutter/material.dart';
import 'package:ice_shield/data_layer/DomainData/Plugin/GPSTracker/PersonProfile.dart';
import 'package:ice_shield/ui_layer/user_page/main_deparment/ProfileHeader.dart';
import 'package:ice_shield/ui_layer/user_page/main_deparment/HealthSectionCard.dart';
import 'package:ice_shield/ui_layer/user_page/main_deparment/FinanceSectionCard.dart';
import 'package:ice_shield/ui_layer/user_page/main_deparment/SocialSectionCard.dart';
import 'package:ice_shield/ui_layer/user_page/main_deparment/ProjectSectionCard.dart';
import 'package:go_router/go_router.dart';
import 'package:ice_shield/ui_layer/home_page/MainButton.dart';
import 'package:ice_shield/orchestration_layer/ReactiveBlock/User/AuthBlock.dart';
import 'package:provider/provider.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:ice_shield/orchestration_layer/ReactiveBlock/User/PersonBlock.dart';
import 'package:ice_shield/orchestration_layer/ReactiveBlock/User/ObjectDatabaseBlock.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ProfileDashboardPage extends StatelessWidget {
  const ProfileDashboardPage({super.key});

  static Widget icon(BuildContext context, {double? size}) {
    return MainButton(
      type: "profile",
      destination: "/profile",
      size: size,
      icon: Icons.edit,
      mainFunction: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Edit Profile feature coming soon!'),
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
    final textTheme = Theme.of(context).textTheme;
    return Watch((context) {
      final authBlock = context.watch<AuthBlock>();
      final personBlock = context.watch<PersonBlock>();
      final objectBlock = context.watch<ObjectDatabaseBlock>();

      final info = personBlock.information.watch(context);
      final objectResource = objectBlock.userObjectResource.watch(context);

      final displayName = info.profiles.firstName.isNotEmpty
          ? "${info.profiles.firstName} ${info.profiles.lastName}"
          : authBlock.username.value ?? 'DuyLong Art';

      // Use actual data from signals
      final profile = PersonProfile(
        id: info.profiles.id?.toString() ?? '1',
        name: displayName,
        email:
            "@${info.profiles.alias.split('-').first}", // Using alias as "email/handle" placeholder
        avatarUrl: objectResource.avatarImage.isNotEmpty
            ? objectResource.avatarImage
            : info.profiles.profileImageUrl,
        health: const HealthMetrics(
          todaySteps: 10234,
          caloriesConsumed: 1800,
          caloriesBurned: 520,
          sleepHours: 7.5,
          heartRate: 72,
        ),
        finance: const FinanceMetrics(
          balance: 5420.00,
          monthlyIncome: 6500.00,
          monthlyExpenses: 2100.00,
          savingsRate: 0.35,
        ),
        social: SocialMetrics(
          friendsCount: info.profiles.friends,
          unreadMessages: 5,
          upcomingEvents: 3,
        ),
        projects: const ProjectMetrics(
          activeProjects: 4,
          completedProjects: 12,
          tasksToday: 7,
        ),
      );

      return Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          title: // Wrap your Text in AutoSizeText
          AutoSizeText(
            'Life Dashboard',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
            minFontSize: 12, // Prevents it from becoming unreadable
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          centerTitle: true,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Profile Header
              ProfileHeader(profile: profile),

              const SizedBox(height: 24),

              // Section Title
              Text(
                'Life Dashboard',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              // 2x2 Grid of Section Cards
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85,
                children: [
                  HealthSectionCard(
                    metrics: profile.health,
                    onTap: () => context.go('/health'),
                  ),
                  FinanceSectionCard(
                    metrics: profile.finance,
                    onTap: () => context.go('/finance'),
                  ),
                  SocialSectionCard(
                    metrics: profile.social,
                    onTap: () => context.go('/social'),
                  ),
                  ProjectSectionCard(
                    metrics: profile.projects,
                    onTap: () => context.go('/projects'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
