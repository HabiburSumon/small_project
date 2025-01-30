// Widgets
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CategoryCard({super.key, required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class DietRecommendationCard extends StatelessWidget {
  final String label;
  final String time;
  final String calories;
  final bool isEasy;
  final void Function(String label) onViewDetails;

  const DietRecommendationCard({
    super.key,
    required this.label,
    required this.time,
    required this.calories,
    required this.isEasy,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isEasy ? [Colors.green, Colors.lightGreenAccent] : [Colors.redAccent, Colors.orangeAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          title: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          subtitle: Text(
            '$time | $calories',
            style: const TextStyle(color: Colors.white70),
          ),
          trailing: TextButton(
            onPressed: () => onViewDetails(label),
            child: const Text(
              'View Details',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
