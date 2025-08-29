// lib/widgets/dashboard_container.dart

import 'package:flutter/material.dart';
import 'package:job_portal/ui_helper/ui_helper.dart'; // for mTextStyle12, mTextStyle14
import 'package:job_portal/utils/theme/custom_themes/color_theme.dart'; // for TColors

class DashboardContainer extends StatelessWidget {
  final String heading;
  final String subHeading;
  final String actionButtonText;
  final String notificationNum;
  final VoidCallback onTap;

  const DashboardContainer({
    super.key,
    required this.heading,
    required this.subHeading,
    required this.actionButtonText,
    required this.notificationNum,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Title + More Icon
            Row(
              children: [
                Text(
                  heading,
                  style: mTextStyle14(mFontWeight: FontWeight.w600),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    // Optional: Add menu or navigate
                  },
                  child: const Icon(Icons.more_horiz, size: 20, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 9),

            // Subtitle
            Text(
              subHeading,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.blueTextColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 12),

            // Action Button with Notification
            Container(
              height: 26,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: TColors.secondary, // Red/orange color from your theme
              ),
              child: InkWell(
                onTap: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      actionButtonText,
                      style: mTextStyle12(mColor: Colors.white),
                    ),
                    if (notificationNum.isNotEmpty)
                      const SizedBox(width: 3),
                    if (notificationNum.isNotEmpty)
                      Text(
                        notificationNum,
                        style: mTextStyle12(mColor: Colors.white),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}