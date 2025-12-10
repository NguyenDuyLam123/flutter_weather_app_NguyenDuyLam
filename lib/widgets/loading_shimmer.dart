// lib/widgets/loading_shimmer.dart
import 'package:flutter/material.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // Simple skeleton cards
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 12),
      children: List.generate(4, (i) => _card(context)),
    );
  }

  Widget _card(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Container(
        height: 110,
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(width: 80, height: 80, color: Colors.grey.shade300),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 18, color: Colors.grey.shade300),
                  const SizedBox(height: 8),
                  Container(height: 14, color: Colors.grey.shade300),
                  const SizedBox(height: 8),
                  Container(
                    height: 14,
                    width: 120,
                    color: Colors.grey.shade300,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
