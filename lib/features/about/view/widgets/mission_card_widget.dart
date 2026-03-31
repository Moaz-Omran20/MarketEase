import 'package:flutter/material.dart';

class MissionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const MissionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.07),
            width: 1,
          ),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF140B32), // top-left: deep indigo
              Color(0xFF140B32), // mid
              Color(0xFF140B32), // bottom-right: near black
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon container
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF140B32), // top-left: deep indigo
                    Color(0xFF140B32), // mid
                    Color(0xFF140B32), // bottom-right: near black
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                  width: 1,
                ),
              ),
              child: Icon(icon, color: const Color(0xFF9B7EFF), size: 30),
            ),

            const SizedBox(height: 18),

            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.1,
              ),
            ),

            const SizedBox(height: 8),

            // Description
            Text(
              description,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
                height: 1.65,
                color: Colors.white.withValues(alpha: 0.5),
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
