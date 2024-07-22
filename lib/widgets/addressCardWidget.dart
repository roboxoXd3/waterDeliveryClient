import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final Map<String, dynamic> address;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool isSelected;

  const AddressCard({
    super.key,
    required this.address,
    this.onEdit,
    this.onDelete,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isSelected
            ? BorderSide(color: Theme.of(context).primaryColor, width: 2)
            : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  address['nickname'] ?? 'Address',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (address['is_default'] == true)
                  Chip(
                    label: const Text('Default'),
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(0.1),
                    labelStyle:
                        TextStyle(color: Theme.of(context).primaryColor),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(address['street'] ?? ''),
            Text(
                '${address['city']}, ${address['state']} ${address['postal_code']}'),
            Text(address['country'] ?? ''),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (onEdit != null)
                  TextButton.icon(
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Edit'),
                    onPressed: onEdit,
                  ),
                if (onDelete != null)
                  TextButton.icon(
                    icon: const Icon(Icons.delete, size: 18),
                    label: const Text('Delete'),
                    onPressed: onDelete,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
