import 'dart:convert';

final String json_data = '''{
  "access_token": "0DKZIvTRq0mKJ7h",
  "model_version": "plant_id:3.6.0",
  "custom_id": null,
  "input": {
    "latitude": 49.207,
    "longitude": 16.608,
    "similar_images": true,
    "health": "only",
    "images": [
      "https://plant.id/media/imgs/d90f90d88580416785ee63ee1b3fc469.jpg"
    ],
    "datetime": "2024-02-20T14:07:37.264107+00:00"
  },
  "result": {
    "is_plant": {
      "probability": 0.9999981,
      "threshold": 0.5,
      "binary": true
    },
    "is_healthy": {
      "binary": true,
      "threshold": 0.525,
      "probability": 0.9436147622764111
    },
    "disease": {
      "suggestions": [
        {
          "id": "5b5b0081922d3c45",
          "name": "finished flowering period",
          "probability": 0.1519,
          "similar_images": [
            {
              "id": "da605ab116d152a48fc9751849cc90d6b647235f",
              "url": "https://plant-id.ams3.cdn.digitaloceanspaces.com/similar_images/3/da6/05ab116d152a48fc9751849cc90d6b647235f.jpg",
              "similarity": 0.579,
              "url_small": "https://plant-id.ams3.cdn.digitaloceanspaces.com/similar_images/3/da6/05ab116d152a48fc9751849cc90d6b647235f.small.jpg"
            },
            {
              "id": "84c56fac1a640b84a577c8c284ea81bcc2842cc1",
              "url": "https://plant-id.ams3.cdn.digitaloceanspaces.com/similar_images/3/84c/56fac1a640b84a577c8c284ea81bcc2842cc1.jpg",
              "similarity": 0.563,
              "url_small": "https://plant-id.ams3.cdn.digitaloceanspaces.com/similar_images/3/84c/56fac1a640b84a577c8c284ea81bcc2842cc1.small.jpg"
            }
          ],
          "details": {
            "local_name": "finished flowering period",
            "description": "The finished flowering period is part of the physiological process when the flowers die at the end of the flowering period. If fertilized, flowers develop into fruits.",
            "url": null,
            "treatment": {
              "prevention": [
                "Regularly remove flowers that have finished flowering. This will encourage the growth of new flowers.",
                "Supply the plant with a fertilizer high in phosphorus, which is good for flowers. Follow the instructions on the chosen product to prevent excessive fertilizer usage."
              ]
            },
            "classification": [
              "Senescence",
              "Natural senescence"
            ],
            "common_names": null,
            "cause": null,
            "language": "en",
            "entity_id": "5b5b0081922d3c45"
          }
        },
        {
          "id": "af7b78782de52bd8",
          "name": "senescence",
          "probability": 0.1277,
          "similar_images": [
            {
              "id": "de05d50d870c11502387c2460c7ff4d0d8ab6213",
              "url": "https://plant-id.ams3.cdn.digitaloceanspaces.com/similar_images/3/de0/5d50d870c11502387c2460c7ff4d0d8ab6213.jpg",
              "similarity": 0.564,
              "url_small": "https://plant-id.ams3.cdn.digitaloceanspaces.com/similar_images/3/de0/5d50d870c11502387c2460c7ff4d0d8ab6213.small.jpg"
            },
            {
              "id": "84c56fac1a640b84a577c8c284ea81bcc2842cc1",
              "url": "https://plant-id.ams3.cdn.digitaloceanspaces.com/similar_images/3/84c/56fac1a640b84a577c8c284ea81bcc2842cc1.jpg",
              "similarity": 0.563,
              "url_small": "https://plant-id.ams3.cdn.digitaloceanspaces.com/similar_images/3/84c/56fac1a640b84a577c8c284ea81bcc2842cc1.small.jpg"
            }
          ],
          "details": {
            "local_name": "senescence",
            "description": "Senescence is a process of aging that can occur due to physiological aging or environmental stress.",
            "url": "https://en.wikipedia.org/wiki/Plant_senescence",
            "treatment": {
              "biological": [
                "Remove dead parts of the plant."
              ],
              "prevention": [
                "Prevent plant stress by optimal watering, fertilizing and protection from sun and frost."
              ]
            },
            "classification": [],
            "common_names": [
              "aging"
            ],
            "cause": null,
            "language": "en",
            "entity_id": "af7b78782de52bd8"
          }
        },
        {
          "id": "7f22438065988f95",
          "name": "Fungi",
          "probability": 0.0259,
          "similar_images": [
            {
              "id": "8508b30abe1b250e08cc76102ef726d18dc8bba8",
              "url": "https://plant-id.ams3.cdn.digitaloceanspaces.com/similar_images/3/850/8b30abe1b250e08cc76102ef726d18dc8bba8.jpeg",
              "license_name": "CC BY 3.0",
              "license_url": "https://creativecommons.org/licenses/by/3.0/",
              "citation": "Linda Haugen, USDA Forest Service, Bugwood.org ",
              "similarity": 0.437,
              "url_small": "https://plant-id.ams3.cdn.digitaloceanspaces.com/similar_images/3/850/8b30abe1b250e08cc76102ef726d18dc8bba8.small.jpeg"
            },
            {
              "id": "6091a8c16edded96a92218b7b3498e0825445b4d",
              "url": "https://plant-id.ams3.cdn.digitaloceanspaces.com/similar_images/3/609/1a8c16edded96a92218b7b3498e0825445b4d.jpg",
              "similarity": 0.376,
              "url_small": "https://plant-id.ams3.cdn.digitaloceanspaces.com/similar_images/3/609/1a8c16edded96a92218b7b3498e0825445b4d.small.jpg"
            }
          ],
          "details": {
            "local_name": "Fungi",
            "description": "Fungi take energy from the plants on which they live, causing damage to the plant. Fungal infections are responsible for approximately two-thirds of infectious plant diseases and cause wilting, molding, rusts, scabs, rotted tissue, and other problems.",
            "url": "https://en.wikipedia.org/wiki/Fungus",
            "treatment": {
              "chemical": [
                "If necessary, apply a fungicide. If you don' know the fungus species, choose fungicide based on the infected plant (e.g. house plant, garden plant, tree)."
              ],
              "biological": [
                "If possible remove and destroy the infected parts of the plant. Burn it, toss it into the garbage, or bury it deeply. Do not compost.",
                "Apply ecological products for plant protection (e.g. neem oil, baking soda, soap)."
              ],
              "prevention": [
                "Use resistant species and cultivars as well as healthy, certified seeds and seedlings.",
                "Ensure having good soil drainage to avoid overwatering.",
                "Improve the air circulation around the plant (e.g. by pruning excess foliage or increasing the spacing between plants).",
                "Avoid prolonged wetting of the leaves, which can be caused e.g. by overhead irrigation.",
                "Rotate crops. Avoid planting sensitive crops in infested soil.",
                "Disinfect tools, infected flower pots, and hands to avoid disease transmission."
              ]
            },
            "classification": [],
            "common_names": null,
            "cause": null,
            "language": "en",
            "entity_id": "7f22438065988f95"
          }
        }
      ]
    }
  },
  "status": "COMPLETED",
  "sla_compliant_client": true,
  "sla_compliant_system": true,
  "created": 1708438057.264107,
  "completed": 1708438057.724563
}''';

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

void main() {
  final Map<String, dynamic> data = json.decode(json_data);
  final List<dynamic> suggestions = data['result']['disease']['suggestions'];
  for (final suggestion in suggestions) {
    final plantSuggestion = PlantHealthCareSuggestion.fromJson(suggestion);
    print('Plant name: ${plantSuggestion.name}');
    print('Image URL: ${plantSuggestion.urlImage}');
    print('Description: ${plantSuggestion.description}');
    print(
        'Chemical treatment: ${plantSuggestion.treatmentChemical.toString()}');
    print(
        'Biological treatment: ${plantSuggestion.treatmentBiological.toString()}');
    print('Prevention: ${plantSuggestion.treatmentPrevention.toString()}');
    print('Probability: ${plantSuggestion.probability}%');
    print('-----------------------------------');
  }
  //print(json_data);
}
