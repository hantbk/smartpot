class PlantHealthCareSuggestion {
  final String name;
  final int probability;
  final String urlImage;
  final String description;
  final List<String> treatmentChemical;
  final List<String> treatmentBiological;
  final List<String> treatmentPrevention;

  PlantHealthCareSuggestion({
    required this.name,
    required this.probability,
    required this.urlImage,
    required this.description,
    required this.treatmentChemical,
    required this.treatmentBiological,
    required this.treatmentPrevention,
  });

  factory PlantHealthCareSuggestion.fromJson(Map<String, dynamic> suggestion) {
    return PlantHealthCareSuggestion(
        name: suggestion['name'],
        probability: (suggestion['probability'] * 100).toInt(),
        urlImage: suggestion['similar_images'][0]['url'],
        description: suggestion['details']['description'],
        treatmentChemical:
            (suggestion['details']['treatment']['chemical'] ?? [])
                .cast<String>(),
        treatmentBiological:
            (suggestion['details']['treatment']['biological'] ?? [])
                .cast<String>(),
        treatmentPrevention:
            (suggestion['details']['treatment']['prevention'] ?? [])
                .cast<String>());
  }
}
