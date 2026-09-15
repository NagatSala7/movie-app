import 'package:flutter/material.dart';

class MovieDetailsTabs extends StatelessWidget {
  final int selectedTabIndex;
  final ValueChanged<int> onTabSelected;

  const MovieDetailsTabs({
    super.key,
    required this.selectedTabIndex,
    required this.onTabSelected,
  });

  Widget _buildTab({
    required String title,
    required int index,
  }) {
    final isSelected = selectedTabIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTabSelected(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : const Color(0xff92929D),
                fontSize: 12,
                fontWeight: isSelected
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              height: 3,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xff3A3F47)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Row(
        children: [
          _buildTab(
            title: "About Movie",
            index: 0,
          ),
          _buildTab(
            title: "Reviews",
            index: 1,
          ),
          _buildTab(
            title: "Cast",
            index: 2,
          ),
        ],
      ),
    );
  }
}