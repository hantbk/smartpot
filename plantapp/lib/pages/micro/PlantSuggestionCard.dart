import 'package:flutter/material.dart';
import 'package:plantapp/pages/models/PlantSuggestion.dart';

class PlantSuggestionCard extends StatelessWidget {
  final String name;
  final String similarImageUrl;
  final String description;
  final String bestLightCondition;
  final String bestSoilType;
  final String bestWatering;

  PlantSuggestionCard(PlantSuggestion suggestion, {super.key})
      : name = suggestion.name,
        similarImageUrl = suggestion.urlImage,
        description = suggestion.description,
        bestLightCondition = suggestion.bestLightCondition,
        bestSoilType = suggestion.bestSoilType,
        bestWatering = suggestion.bestWatering;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Similar Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.network(
              similarImageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          // Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
          const Divider(),
          // Details Section
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(
                  icon: Icons.wb_sunny,
                  label: "Best Light Condition",
                  content: bestLightCondition,
                ),
                const SizedBox(height: 8),
                _buildInfoRow(
                  icon: Icons.grass,
                  label: "Best Soil Type",
                  content: bestSoilType,
                ),
                const SizedBox(height: 8),
                _buildInfoRow(
                  icon: Icons.water_drop,
                  label: "Best Watering",
                  content: bestWatering,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.green),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: '$label: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: content,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
