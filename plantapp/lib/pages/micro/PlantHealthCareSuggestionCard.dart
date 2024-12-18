import 'package:flutter/material.dart';

import '../models/PlantHealthCareSuggestion.dart';

class PlantHealthCareSuggestionCard extends StatelessWidget {
  final String name;
  final int probability;
  final String similarImageUrl;
  final String description;
  final List<String> treatmentChemical;
  final List<String> treatmentBiological;
  final List<String> treatmentPrevention;

  PlantHealthCareSuggestionCard(PlantHealthCareSuggestion suggestion, {super.key})
      : name = suggestion.name,
        probability = suggestion.probability,
        similarImageUrl = suggestion.urlImage,
        description = suggestion.description,
        treatmentChemical = suggestion.treatmentChemical,
        treatmentBiological = suggestion.treatmentBiological,
        treatmentPrevention = suggestion.treatmentPrevention;

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
              '$name: (${probability.toString()}%)',
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
          // Treatment Details
          if (treatmentChemical.isNotEmpty ||
              treatmentBiological.isNotEmpty ||
              treatmentPrevention.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (treatmentChemical.isNotEmpty)
                    _buildTreatmentSection(
                      "Chemical Treatment",
                      treatmentChemical,
                    ),
                  if (treatmentBiological.isNotEmpty)
                    _buildTreatmentSection(
                      "Biological Treatment",
                      treatmentBiological,
                    ),
                  if (treatmentPrevention.isNotEmpty)
                    _buildTreatmentSection(
                      "Prevention",
                      treatmentPrevention,
                    ),
                ],
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "No treatment suggestions available.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTreatmentSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 5),
        for (final item in items)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check, size: 16, color: Colors.green),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
