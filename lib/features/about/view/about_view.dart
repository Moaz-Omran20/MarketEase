import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_ease/features/about/view/widgets/journey_widget.dart';
import 'package:market_ease/features/about/view/widgets/mission_card_widget.dart';
import 'package:market_ease/features/about/view/widgets/profile_card.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About", style: Theme.of(context).textTheme.titleMedium),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            JourneyWidget(),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Our Mission",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Divider(color: Colors.white, height: 2, thickness: 2),
                ],
              ),
            ),
            SizedBox(height: 16),
            MissionCard(
              icon: Icons.check_circle_outline_rounded,
              title: 'Quality',
              description:
                  'Curating only the finest essentials for your lifestyle, verified by rigorous standards.',
            ),

            const SizedBox(height: 16),

            MissionCard(
              icon: Icons.bolt_outlined,
              title: 'Efficiency',
              description:
                  'Seamless checkout and lightning-fast logistics designed for your pace of life.',
            ),

            const SizedBox(height: 16),

            MissionCard(
              icon: Icons.favorite_border_rounded,
              title: 'Customer Focus',
              description:
                  'An obsessive dedication to making every interaction intuitive and rewarding.',
            ),
            SizedBox(height: 50.h),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ProfileCard(),
            ),
          ],
        ),
      ),
    );
  }
}

