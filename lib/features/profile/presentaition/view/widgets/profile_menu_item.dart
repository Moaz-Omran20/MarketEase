import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool? isLogout;

  const ProfileMenuItem({
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
