import 'dart:convert';

final String json_data = '''{
  "access_token": "CtrjYkVtwJseMWs",
  "model_version": "plant_id:4.0.2",
  "custom_id": null,
  "input": {
    "latitude": 49.207,
    "longitude": 16.608,
    "similar_images": true,
    "images": [
      "https://plant.id/media/imgs/0f6ed1169d8442319fda1f9987e4210f.jpg"
    ],
    "datetime": "2024-08-05T08:16:45.899943+00:00"
  },
  "result": {
    "is_plant": {"probability": 0.99096996, "threshold": 0.5, "binary": true},
    "classification": {
      "suggestions": [
        {
          "id": "872243f84209c0c2",
          "name": "Buddleja davidii",
          "probability": 0.9892,
          "similar_images": [
            {
              "id": "909f07fbf17c7dab80a175a1649173b24ae6adb6",
              "url":
                  "https://plant-id.ams3.cdn.digitaloceanspaces.com/similar_images/4/909/f07fbf17c7dab80a175a1649173b24ae6adb6.jpeg",
              "license_name": "CC BY-NC-SA 4.0",
              "license_url":
                  "https://creativecommons.org/licenses/by-nc-sa/4.0/",
              "citation": "FlowerChecker s.r.o.",
              "similarity": 0.758,
              "url_small":
                  "https://plant-id.ams3.cdn.digitaloceanspaces.com/similar_images/4/909/f07fbf17c7dab80a175a1649173b24ae6adb6.small.jpeg"
            },
            {
              "id": "808c7d58dabe9c3486549ea3e83de2fd9e86d581",
              "url":
                  "https://plant-id.ams3.cdn.digitaloceanspaces.com/similar_images/4/808/c7d58dabe9c3486549ea3e83de2fd9e86d581.jpeg",
              "license_name": "CC BY-NC-SA 4.0",
              "license_url":
                  "https://creativecommons.org/licenses/by-nc-sa/4.0/",
              "citation": "FlowerChecker s.r.o.",
              "similarity": 0.741,
              "url_small":
                  "https://plant-id.ams3.cdn.digitaloceanspaces.com/similar_images/4/808/c7d58dabe9c3486549ea3e83de2fd9e86d581.small.jpeg"
            }
          ],
          "details": {
            "common_names": [
              "orange-eyed butterfly-bush",
              "Butterfly bush",
              "summer lilac",
              "orange-eye butterfly bush",
              "Chinese Sagewood"
            ],
            "taxonomy": {
              "class": "Magnoliopsida",
              "genus": "Buddleja",
              "order": "Lamiales",
              "family": "Scrophulariaceae",
              "phylum": "Tracheophyta",
              "kingdom": "Plantae"
            },
            "url": "https://en.wikipedia.org/wiki/Buddleja_davidii",
            "gbif_id": 3173338,
            "inaturalist_id": 75916,
            "rank": "species",
            "description": {
              "value":
                  "Buddleja davidii (spelling variant Buddleia davidii), also called summer lilac, butterfly-bush, or orange eye, is a species of flowering plant in the family Scrophulariaceae, native to Sichuan and Hubei provinces in central China, and also Japan. It is widely used as an ornamental plant, and many named varieties are in cultivation. The genus was named Buddleja after Reverend Adam Buddle, an English botanist. The species name davidii honors the French missionary and explorer in China, Father Armand David, who was the first European to report the shrub. It was found near Ichang by Dr Augustine Henry about 1887 and sent to St Petersburg.  Another botanist-missionary in China, Jean-André Soulié, sent seed to the French nursery Vilmorin, and B. davidii entered commerce in the 1890s.B. davidii was accorded the RHS Award of Merit (AM) in 1898, and the Award of Garden Merit (AGM) in 1941.",
              "citation": "https://en.wikipedia.org/wiki/Buddleja_davidii",
              "license_name": "CC BY-SA 3.0",
              "license_url": "https://creativecommons.org/licenses/by-sa/3.0/"
            },
            "synonyms": [
              "Buddleia davidii",
              "Buddleja davidii subsp. glabrescens",
              "Buddleja davidii subsp. nanhoensis",
              "Buddleja davidii subsp. veitchiana",
              "Buddleja davidii var. alba",
              "Buddleja davidii var. glabrescens",
              "Buddleja davidii var. magnifera",
              "Buddleja davidii var. magnifica",
              "Buddleja davidii var. nanhoensis",
              "Buddleja davidii var. superba",
              "Buddleja davidii var. veitchiana",
              "Buddleja davidii var. wilsonii",
              "Buddleja delavayi var. tomentosa",
              "Buddleja heliophila var. adenophora",
              "Buddleja shaanxiensis",
              "Buddleja shimidzuana",
              "Buddleja striata",
              "Buddleja striata var. zhouquensis",
              "Buddleja variabilis",
              "Buddleja variabilis subsp. nanhoensis",
              "Buddleja variabilis subsp. prostrata",
              "Buddleja variabilis subsp. superba",
              "Buddleja variabilis subsp. veitchiana",
              "Buddleja variabilis subsp. wilsonii",
              "Buddleja variabilis var. magnifica",
              "Buddleja variabilis var. nanhoensis",
              "Buddleja variabilis var. prostrata",
              "Buddleja variabilis var. superba",
              "Buddleja variabilis var. veitchiana",
              "Buddleja variabilis var. wilsonii",
              "Buddleja veitchiana"
            ],
            "image": {
              "value":
                  "https://plant-id.ams3.cdn.digitaloceanspaces.com/knowledge_base/wikidata/f2a/f2a2bb3653d76b454d65fad5943923f3f16932e3.jpg",
              "citation": "//commons.wikimedia.org/wiki/User:IKAl",
              "license_name": "CC BY-SA 2.5",
              "license_url": "https://creativecommons.org/licenses/by-sa/2.5/"
            },
            "edible_parts": null,
            "watering": {"max": 2, "min": 2},
            "best_light_condition":
                "This plant thrives in full sun, needing at least six hours of direct sunlight each day to perform its best. It can tolerate partial shade, but too much shade can result in fewer flowers and a leggy growth habit. Planting it in a sunny spot will encourage robust growth and abundant blooms, making it a standout in any garden.",
            "best_soil_type":
                "For optimal growth, this plant prefers well-drained soil that is moderately fertile. It can tolerate a range of soil types, including sandy, loamy, and clay soils, as long as there is good drainage. Adding organic matter like compost can improve soil fertility and structure, helping the plant to establish and thrive.",
            "common_uses":
                "Common uses for this plant include ornamental landscaping and wildlife gardens. It is often used as a focal point in garden beds, borders, and as a hedge. Its ability to attract butterflies and bees makes it a valuable addition to pollinator gardens. Additionally, its cut flowers can be used in floral arrangements, adding a splash of color and fragrance to indoor spaces.",
            "cultural_significance":
                "In various cultures, this plant is valued for its ornamental beauty and its ability to attract butterflies and other pollinators. It is often planted in butterfly gardens and is associated with themes of transformation and beauty. Its vibrant flowers and pleasant fragrance make it a popular choice in many gardens around the world.",
            "toxicity":
                "This plant is considered mildly toxic to both humans and animals if ingested. It can cause stomach upset and other gastrointestinal issues. While it is not highly toxic, it is best to keep it out of reach of pets and children to prevent accidental ingestion. Always wash hands after handling the plant to avoid any potential skin irritation.",
            "best_watering":
                "Watering this plant requires a balanced approach. It prefers well-drained soil and does not like to sit in water. Water it deeply but infrequently, allowing the soil to dry out between waterings. During the growing season, typically spring and summer, it may need more frequent watering, especially in hot, dry conditions. In contrast, reduce watering in the fall and winter when the plant is not actively growing.",
            "language": "en",
            "entity_id": "872243f84209c0c2"
          }
        },
        {
          "id": "3514ca9d9bfbba10",
          "name": "Buddleja japonica",
          "probability": 0.0108,
          "similar_images": [
            {
              "id": "23054bfca484d221f66f172d03242896f1ea9cdb",
              "url":
                  "https://plant-id.ams3.cdn.digitaloceanspaces.com/similar_images/4/230/54bfca484d221f66f172d03242896f1ea9cdb.jpeg",
              "license_name": "CC BY-SA 4.0",
              "license_url": "https://creativecommons.org/licenses/by-sa/4.0/",
              "citation": "Valentina Diakovasiliou",
              "similarity": 0.723,
              "url_small":
                  "https://plant-id.ams3.cdn.digitaloceanspaces.com/similar_images/4/230/54bfca484d221f66f172d03242896f1ea9cdb.small.jpeg"
            },
            {
              "id": "de6fb384640a6b498d452cd4da81f2cd52be41fe",
              "url":
                  "https://plant-id.ams3.cdn.digitaloceanspaces.com/similar_images/4/de6/fb384640a6b498d452cd4da81f2cd52be41fe.jpeg",
              "license_name": "CC BY 4.0",
              "license_url": "https://creativecommons.org/licenses/by/4.0/",
              "citation": "joffrey calvel",
              "similarity": 0.697,
              "url_small":
                  "https://plant-id.ams3.cdn.digitaloceanspaces.com/similar_images/4/de6/fb384640a6b498d452cd4da81f2cd52be41fe.small.jpeg"
            }
          ],
          "details": {
            "common_names": null,
            "taxonomy": {
              "class": "Magnoliopsida",
              "genus": "Buddleja",
              "order": "Lamiales",
              "family": "Scrophulariaceae",
              "phylum": "Tracheophyta",
              "kingdom": "Plantae"
            },
            "url": "https://en.wikipedia.org/wiki/Buddleja_japonica",
            "gbif_id": 4055769,
            "inaturalist_id": 509187,
            "rank": "species",
            "description": {
              "value":
                  "Buddleja japonica is a deciduous shrub native to Honshu and Shikoku,  Japan, where it grows on mountain slopes amid scrub. The shrub was named and described by Hemsley in 1889, and introduced to Western cultivation in 1896.",
              "citation": "https://en.wikipedia.org/wiki/Buddleja_japonica",
              "license_name": "CC BY-SA 3.0",
              "license_url": "https://creativecommons.org/licenses/by-sa/3.0/"
            },
            "synonyms": ["Buddleja japonica f. albiflora"],
            "image": {
              "value":
                  "https://plant-id.ams3.cdn.digitaloceanspaces.com/knowledge_base/wikidata/0a1/0a119525a9eac1ff4b5a745aec74191088216d4a.jpg",
              "citation":
                  "https://commons.wikimedia.org/wiki/File:Buddleja_japonica1.jpg",
              "license_name": "CC BY-SA 3.0",
              "license_url": "https://creativecommons.org/licenses/by-sa/3.0/"
            },
            "edible_parts": null,
            "watering": null,
            "best_light_condition":
                "This plant thrives in full sun to partial shade. It needs at least six hours of direct sunlight each day for optimal growth and flowering. If grown in partial shade, it may produce fewer flowers. However, it can tolerate some shade, especially in hotter climates where intense afternoon sun might be too harsh.",
            "best_soil_type":
                "Well-draining soil is essential for healthy growth. A mix of loamy soil with some sand or perlite works well to ensure proper drainage. The soil should be rich in organic matter to provide necessary nutrients. Avoid heavy clay soils that retain too much moisture, as this can lead to root problems.",
            "common_uses":
                "Common uses include planting in garden beds, borders, and as a part of mixed shrub plantings. It is also used in butterfly gardens to attract pollinators. The plant's flowers can be cut and used in floral arrangements. Additionally, it can serve as a decorative element in public parks and private gardens due to its attractive blooms.",
            "cultural_significance":
                "In some cultures, this plant is valued for its ornamental beauty and is often used in gardens and landscapes. It is sometimes associated with attracting butterflies and other pollinators, making it a popular choice for butterfly gardens. Its flowers are also used in traditional floral arrangements.",
            "toxicity":
                "This plant is generally considered non-toxic to both humans and animals. There are no known harmful effects if touched or ingested. However, it's always a good practice to supervise pets and children around any plant, as individual reactions can vary.",
            "best_watering":
                "Watering should be done regularly but not excessively. The soil should be kept moist, especially during the growing season. It's important to let the top inch of soil dry out between waterings to prevent root rot. During the winter months, reduce the frequency of watering as the plant's growth slows down.",
            "language": "en",
            "entity_id": "3514ca9d9bfbba10"
          }
        }
      ]
    }
  },
  "status": "COMPLETED",
  "sla_compliant_client": false,
  "sla_compliant_system": true,
  "created": 1722845805.899943,
  "completed": 1722845806.315829
}''';

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

void main() {
  final Map<String, dynamic> data = json.decode(json_data);
  final List<dynamic> suggestions =
      data['result']['classification']['suggestions'];
  for (final suggestion in suggestions) {
    final plantSuggestion = PlantSuggestion.fromJson(suggestion);
    print('Plant name: ${plantSuggestion.name}');
    print('Image URL: ${plantSuggestion.urlImage}');
    print('Description: ${plantSuggestion.description}');
    print('Best light condition: ${plantSuggestion.bestLightCondition}');
    print('Best soil type: ${plantSuggestion.bestSoilType}');
    print('Best watering: ${plantSuggestion.bestWatering}');
    print('');
  }
  //print(json_data);
}
