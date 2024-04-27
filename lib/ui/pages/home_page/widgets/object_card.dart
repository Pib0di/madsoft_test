import 'package:flutter/material.dart';
import 'package:madsoft_test/ui/common/widgets/text_widgets.dart';

class ObjectCard extends StatelessWidget {
  final String title;
  final double memoryAfterPhotos;
  final int totalPointsCount;
  final int remainingPoints;
  final double availableMemory;
  final void Function()? onTap;

  const ObjectCard({
    super.key,
    required this.title,
    required this.memoryAfterPhotos,
    required this.totalPointsCount,
    required this.remainingPoints,
    required this.availableMemory,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Head2(title),
            const SizedBox(height: 16),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Отснято сегодня',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: '$remainingPoints ',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '/ $totalPointsCount доступно',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Съемка займет:',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: '${memoryAfterPhotos.toStringAsFixed(1)} ГБ ',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '/ ${availableMemory.toStringAsFixed(1)} ГБ доступно',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
