// ignore: file_names
class PlantSuggestion {
  final String name;
  final String urlImage;
  final String description;
  final String bestLightCondition;
  final String bestSoilType;
  final String bestWatering;

  PlantSuggestion({
    required this.name,
    required this.urlImage,
    required this.description,
    required this.bestLightCondition,
    required this.bestSoilType,
    required this.bestWatering,
  });

  factory PlantSuggestion.fromJson(Map<String, dynamic> suggestion) {
    return PlantSuggestion(
      name: suggestion['name'],
      urlImage: suggestion['similar_images'][0]['url'],
      description: suggestion['details']['description']['value'],
      bestLightCondition: suggestion['details']['best_light_condition'],
      bestSoilType: suggestion['details']['best_soil_type'],
      bestWatering: suggestion['details']['best_watering'],
    );
  }
}
