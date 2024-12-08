class PlantHealthCareSuggestion {
  final String name;
  final int probability;
  final String urlImage;
  final String description;
  final String treatmentCheical;
  final String tratmentBiological;
  final String treatmentPrevention;

  PlantHealthCareSuggestion({
    required this.name,
    required this.probability,
    required this.urlImage,
    required this.description,
    required this.treatmentCheical,
    required this.tratmentBiological,
    required this.treatmentPrevention,
  });

  factory PlantHealthCareSuggestion.fromJson(Map<String, dynamic> suggestion) {
    return PlantHealthCareSuggestion(
        name: suggestion['name'],
        probability: suggestion['probability'] * 100,
        urlImage: suggestion['similar_images'][0]['url'],
        description: suggestion['details']['description'],
        treatmentCheical: suggestion['details']['treatment']['chemical'],
        tratmentBiological: suggestion['details']['treatment']['biological'],
        treatmentPrevention: suggestion['details']['treatment']['prevention']);
  }
}
