import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Profile",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Card
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6C63FF), Color(0xFFFF6584)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6C63FF).withValues(alpha: 0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'SB',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Name & email
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Samuel Bishop',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'example@gmail.com',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.45),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // Menu Items
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _ProfileMenuItem(
                    onTap: () {},
                    icon: Icons.person,
                    label: 'Personal info',
                  ),
                  const SizedBox(height: 16),

                  _ProfileMenuItem(
                    icon: Icons.location_on_outlined,
                    label: 'Shipping Address',
                  ),
                  const SizedBox(height: 16),

                  _ProfileMenuItem(
                    onTap: () {
                      context.push(AppRoutes.kAboutView);
                    },
                    icon: Icons.info_outline,
                    label: 'About',
                  ),
                  const SizedBox(height: 16),

                  _ProfileMenuItem(
                    onTap: () {
                      context.go(AppRoutes.kLoginVIew);
                    },
                    isLogout: true,
                    icon: Icons.logout,
                    label: 'Logout',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool? isLogout;

  const _ProfileMenuItem({
    required this.icon,
    required this.label,
    this.onTap,
    this.isLogout,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          // Icon circle
          isLogout == true
              ? Icon(Icons.logout, color: Colors.red)
              : Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C63FF).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: const Color(0xFF6C63FF), size: 20),
                ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: isLogout == true
                  ? Theme.of(
                      context,
                    ).textTheme.labelMedium!.copyWith(color: Colors.red)
                  : Theme.of(context).textTheme.labelMedium,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: isLogout == true ? Colors.red : Colors.white,
            size: 16,
          ),
        ],
      ),
    );
  }
}
