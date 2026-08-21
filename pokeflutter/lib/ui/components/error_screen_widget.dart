import 'package:flutter/material.dart';

class ErrorScreenWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const ErrorScreenWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 64.0, // Large error icon for high visibility
            ),
            const SizedBox(height: 16.0),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text(
                  'Try Again'), // Action button to re-trigger data fetch
            ),
          ],
        ),
      ),
    );
  }
}
