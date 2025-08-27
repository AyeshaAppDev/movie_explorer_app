import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/aesthetic_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                Icons.person,
                size: 60,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Movie Explorer',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Discover amazing movies',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 32),
            _buildProfileSection(
              context,
              'Account',
              [
                _buildProfileItem(
                  context,
                  Icons.person_outline,
                  'Edit Profile',
                  () {},
                ),
                _buildProfileItem(
                  context,
                  Icons.notifications_outlined,
                  'Notifications',
                  () {},
                ),
                _buildProfileItem(
                  context,
                  Icons.security,
                  'Privacy & Security',
                  () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildProfileSection(
              context,
              'Preferences',
              [
                _buildProfileItem(
                  context,
                  Icons.palette_outlined,
                  'Theme',
                  () {},
                ),
                _buildProfileItem(
                  context,
                  Icons.language,
                  'Language',
                  () {},
                ),
                _buildProfileItem(
                  context,
                  Icons.download_outlined,
                  'Download Quality',
                  () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildProfileSection(
              context,
              'Support',
              [
                _buildProfileItem(
                  context,
                  Icons.help_outline,
                  'Help Center',
                  () {},
                ),
                _buildProfileItem(
                  context,
                  Icons.feedback_outlined,
                  'Send Feedback',
                  () {},
                ),
                _buildProfileItem(
                  context,
                  Icons.info_outline,
                  'About',
                  () {},
                ),
              ],
            ),
            const SizedBox(height: 32),
            AestheticButton(
              text: 'Sign Out',
              icon: Icons.logout,
              isOutlined: true,
              color: Colors.red,
              onPressed: () {},
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(
    BuildContext context,
    String title,
    List<Widget> items,
  ) {
    return AestheticCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          ...items,
        ],
      ),
    );
  }

  Widget _buildProfileItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}