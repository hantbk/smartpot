// ignore: file_names
class Plant {
  final int id;
  final String name;
  final String imageUrl;
  final String description;
  final String temperatureAdvice;
  final String soilMoistureAdvice;
  final String wateringCycleAdvice;
  final String lightAdvice;

  Plant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.temperatureAdvice,
    required this.soilMoistureAdvice,
    required this.wateringCycleAdvice,
    required this.lightAdvice,
  });
}

List<Plant> plants = [
  Plant(
    id: 1,
    name: "Cây Kim Tiền",
    imageUrl: "lib/images/cay-kim-tien.jpg",
    description: "Cây Kim Tiền là loài cây dễ chăm sóc và mang lại may mắn.",
    temperatureAdvice: "Nhiệt độ lý tưởng: 18-25°C.",
    soilMoistureAdvice: "Giữ ẩm vừa phải, không để đất quá ướt.",
    wateringCycleAdvice: "2-3 lần mỗi tuần.",
    lightAdvice:
        "Cây cần ánh sáng gián tiếp, tránh ánh sáng trực tiếp quá mạnh.",
  ),
  Plant(
    id: 2,
    name: "Cây Trầu Bà",
    imageUrl: "lib/images/cay-trau-ba.jpg",
    description: "Cây Trầu Bà giúp làm sạch không khí trong nhà.",
    temperatureAdvice: "Nhiệt độ lý tưởng: 20-28°C.",
    soilMoistureAdvice: "Đảm bảo đất ẩm, nhưng không quá ướt.",
    wateringCycleAdvice: "Mỗi tuần 1-2 lần.",
    lightAdvice: "Cây thích ánh sáng nhẹ, tránh nắng gắt.",
  ),
  Plant(
    id: 3,
    name: "Cây Lưỡi Hổ",
    imageUrl: "lib/images/cay-luoi-ho.jpg",
    description:
        "Cây Lưỡi Hổ có khả năng thanh lọc không khí và rất dễ chăm sóc.",
    temperatureAdvice: "Nhiệt độ lý tưởng: 18-27°C.",
    soilMoistureAdvice: "Để đất khô hoàn toàn giữa các lần tưới.",
    wateringCycleAdvice: "1-2 lần mỗi tuần.",
    lightAdvice: "Ánh sáng gián tiếp hoặc ánh sáng yếu.",
  ),
  Plant(
    id: 4,
    name: "Cây Phất Dụ",
    imageUrl: "lib/images/cay-phat-du.jpg",
    description:
        "Cây Phất Dụ dễ chăm sóc và có thể sống trong điều kiện ánh sáng yếu.",
    temperatureAdvice: "Nhiệt độ lý tưởng: 18-24°C.",
    soilMoistureAdvice: "Giữ đất ẩm, không để quá ướt.",
    wateringCycleAdvice: "Mỗi tuần 1 lần.",
    lightAdvice: "Cây thích ánh sáng gián tiếp.",
  ),
  Plant(
    id: 5,
    name: "Cây Cọ Nhật",
    imageUrl: "lib/images/cay-co-nhat.jpg",
    description: "Cây Cọ Nhật mang lại không gian tươi mát và dễ chăm sóc.",
    temperatureAdvice: "Nhiệt độ lý tưởng: 18-26°C.",
    soilMoistureAdvice: "Giữ đất ẩm nhưng không quá ướt.",
    wateringCycleAdvice: "Mỗi tuần 1-2 lần.",
    lightAdvice: "Cây cần ánh sáng gián tiếp.",
  ),
  Plant(
    id: 6,
    name: "Cây Bàng Singapore",
    imageUrl: "lib/images/cay-bang-singapore.jpg",
    description:
        "Cây Bàng Singapore có thể chịu được môi trường văn phòng với ánh sáng yếu.",
    temperatureAdvice: "Nhiệt độ lý tưởng: 22-28°C.",
    soilMoistureAdvice: "Giữ đất ẩm vừa phải.",
    wateringCycleAdvice: "Mỗi tuần 1 lần.",
    lightAdvice: "Cây thích ánh sáng gián tiếp.",
  ),
  Plant(
    id: 7,
    name: "Cây Lan Quân Tử",
    imageUrl: "lib/images/cay-lan-quan-tu.jpg",
    description: "Cây Lan Quân Tử dễ trồng và giúp không gian thêm tươi mới.",
    temperatureAdvice: "Nhiệt độ lý tưởng: 18-25°C.",
    soilMoistureAdvice: "Giữ đất ẩm vừa phải.",
    wateringCycleAdvice: "1-2 lần mỗi tuần.",
    lightAdvice: "Cây thích ánh sáng gián tiếp.",
  ),
  Plant(
    id: 8,
    name: "Cây Xương Rồng",
    imageUrl: "lib/images/cay-xuong-rong.jpg",
    description: "Cây Xương Rồng rất dễ chăm sóc và ít yêu cầu về nước.",
    temperatureAdvice: "Nhiệt độ lý tưởng: 20-30°C.",
    soilMoistureAdvice: "Để đất khô hoàn toàn trước khi tưới lại.",
    wateringCycleAdvice: "1 lần mỗi tháng.",
    lightAdvice: "Cây cần ánh sáng mạnh, có thể trực tiếp.",
  ),
  Plant(
    id: 9,
    name: "Cây Lô Hội",
    imageUrl: "lib/images/cay-lo-hoi.jpg",
    description:
        "Cây Lô Hội giúp chữa lành vết thương và dễ chăm sóc trong môi trường văn phòng.",
    temperatureAdvice: "Nhiệt độ lý tưởng: 21-27°C.",
    soilMoistureAdvice: "Giữ đất khô hoàn toàn trước khi tưới lại.",
    wateringCycleAdvice: "Mỗi tuần 1 lần.",
    lightAdvice: "Cây cần ánh sáng gián tiếp.",
  ),
  Plant(
    id: 10,
    name: "Cây Dương Xỉ",
    imageUrl: "lib/images/cay-duong-xi.jpg",
    description:
        "Cây Dương Xỉ là loài cây dễ trồng và giúp làm sạch không khí.",
    temperatureAdvice: "Nhiệt độ lý tưởng: 18-24°C.",
    soilMoistureAdvice: "Cây cần đất luôn ẩm.",
    wateringCycleAdvice: "Mỗi tuần 1 lần.",
    lightAdvice: "Cây thích ánh sáng gián tiếp hoặc bóng râm.",
  ),
  Plant(
    id: 11,
    name: "Cây Sen Đá",
    imageUrl: "lib/images/cay-sen-da.jpg",
    description:
        "Cây Sen Đá thích hợp cho không gian văn phòng với nhu cầu chăm sóc ít.",
    temperatureAdvice: "Nhiệt độ lý tưởng: 20-30°C.",
    soilMoistureAdvice: "Để đất khô hoàn toàn trước khi tưới lại.",
    wateringCycleAdvice: "2 tuần 1 lần.",
    lightAdvice: "Cây cần ánh sáng trực tiếp.",
  ),
];
