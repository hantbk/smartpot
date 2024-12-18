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
  int minHumidity = 0;
  int maxHumidity = 0;
  final String potId;

  Plant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.temperatureAdvice,
    required this.soilMoistureAdvice,
    required this.wateringCycleAdvice,
    required this.lightAdvice,
    required this.minHumidity,
    required this.maxHumidity,
    required this.potId,
  });
}

List<Plant> plants = [
  Plant(
    id: 1,
    name: "Cây Kim Tiền",
    imageUrl: "lib/images/cay-kim-tien.jpeg",
    description:
        "Cây Kim Tiền là một trong những loài cây phong thủy phổ biến nhất, được biết đến với khả năng mang lại tài lộc, sự thịnh vượng và may mắn cho gia chủ. Với vẻ ngoài xanh mướt, thân cây mọng nước và lá hình bầu dục bóng bẩy, cây dễ chăm sóc và thích nghi tốt với nhiều điều kiện sống. Đặc biệt, cây thường được đặt trong phòng khách, văn phòng làm việc hoặc cửa hàng để tạo điểm nhấn xanh mát và thu hút vượng khí.",
    temperatureAdvice: "Nhiệt độ lý tưởng: 18-25°C.",
    soilMoistureAdvice: "Giữ ẩm vừa phải, không để đất quá ướt.",
    wateringCycleAdvice: "2-3 lần mỗi tuần.",
    lightAdvice:
        "Cây cần ánh sáng gián tiếp, tránh ánh sáng trực tiếp quá mạnh.",
    minHumidity: 30,
    maxHumidity: 80,
    potId: "gardenId1",
  ),
  Plant(
    id: 2,
    name: "Cây Trầu Bà",
    imageUrl: "lib/images/cay-trau-ba.jpg",
    description:
        "Cây Trầu Bà không chỉ là một loài cây cảnh trang trí đẹp mắt mà còn có khả năng làm sạch không khí, loại bỏ các chất độc hại như formaldehyde và benzene. Cây có lá hình trái tim mềm mại, tượng trưng cho sự bình an và phát triển bền vững. Trầu Bà rất dễ chăm sóc, phù hợp để trồng trong chậu treo hoặc đặt trên bàn làm việc, mang lại không gian xanh mát và gần gũi với thiên nhiên.",
    temperatureAdvice: "Nhiệt độ lý tưởng: 20-28°C.",
    soilMoistureAdvice: "Đảm bảo đất ẩm, nhưng không quá ướt.",
    wateringCycleAdvice: "Mỗi tuần 1-2 lần.",
    lightAdvice: "Cây thích ánh sáng nhẹ, tránh nắng gắt.",
    minHumidity: 30,
    maxHumidity: 80,
    potId: "gardenId2",
  ),
  Plant(
    id: 3,
    name: "Cây Lưỡi Hổ",
    imageUrl: "lib/images/cay-luoi-ho.jpeg",
    description:
        "Cây Lưỡi Hổ được mệnh danh là máy lọc không khí tự nhiên với khả năng hấp thụ các chất độc hại và tạo oxy vào ban đêm. Lá cây thẳng đứng, cứng cáp với các đường vân xanh đậm và viền vàng tạo nên vẻ đẹp mạnh mẽ, sang trọng. Đây là loài cây rất dễ chăm sóc, thích hợp cho những người bận rộn hoặc ít kinh nghiệm trồng cây. Cây Lưỡi Hổ thường được đặt trong phòng ngủ, phòng khách hoặc văn phòng để cải thiện không khí và phong thủy.",
    temperatureAdvice: "Nhiệt độ lý tưởng: 18-27°C.",
    soilMoistureAdvice: "Để đất khô hoàn toàn giữa các lần tưới.",
    wateringCycleAdvice: "1-2 lần mỗi tuần.",
    lightAdvice: "Ánh sáng gián tiếp hoặc ánh sáng yếu.",
    minHumidity: 30,
    maxHumidity: 80,
    potId: "gardenId2",
  ),
  Plant(
    id: 4,
    name: "Cây huyết phất dụ",
    imageUrl: "lib/images/cay-phat-du.jpeg",
    description:
        "Cây Huyết Phất Dụ, còn gọi là cây Phát Tài Huyết Rồng, mang vẻ đẹp độc đáo với lá dài, mảnh mai và những đường vân đỏ nổi bật. Cây không chỉ có giá trị thẩm mỹ mà còn được xem là biểu tượng của sự may mắn, thành công và sức khỏe. Với khả năng sống tốt trong điều kiện ánh sáng yếu, cây thường được trồng trong nhà, nơi làm việc hoặc quán cà phê để tạo không gian gần gũi và thanh lịch.",
    temperatureAdvice: "Nhiệt độ lý tưởng: 18-24°C.",
    soilMoistureAdvice: "Giữ đất ẩm, không để quá ướt.",
    wateringCycleAdvice: "Mỗi tuần 1 lần.",
    lightAdvice: "Cây thích ánh sáng gián tiếp.",
    minHumidity: 30,
    maxHumidity: 80,
    potId: "gardenId2",
  ),
  Plant(
    id: 5,
    name: "Cây Cọ Nhật",
    imageUrl: "lib/images/cay-co-nhat.jpeg",
    description:
        "Cây Cọ Nhật nổi bật với dáng lá xòe rộng như hình quạt, mang lại vẻ đẹp cổ điển, sang trọng và cảm giác mát mẻ. Đây là loài cây phổ biến trong trang trí nội thất và ngoại thất, giúp tạo không gian thoáng đãng, dễ chịu. Bên cạnh đó, cây còn có khả năng thanh lọc không khí, hấp thụ bụi bẩn và độc tố. Với hình dáng thanh thoát, Cọ Nhật thường được đặt trong phòng khách, ban công hoặc sân vườn.",
    temperatureAdvice: "Nhiệt độ lý tưởng: 18-25°C.",
    soilMoistureAdvice: "Giữ đất ẩm, nhưng không để đọng nước.",
    wateringCycleAdvice: "2-3 lần mỗi tuần.",
    lightAdvice:
        "Cây ưa ánh sáng tự nhiên nhưng không trực tiếp, phù hợp với ánh sáng nhẹ trong nhà.",
    minHumidity: 30,
    maxHumidity: 80,
    potId: "gardenId2",
  ),
  Plant(
    id: 6,
    name: "Cây Bàng Singapore",
    imageUrl: "lib/images/cay-bang-singapore.jpeg",
    description:
        "Cây Bàng Singapore là sự lựa chọn hoàn hảo cho những không gian hiện đại, sang trọng. Với lá to, xanh bóng và mọc đối xứng, cây tạo cảm giác gọn gàng, cân đối và đầy sức sống. Không chỉ đẹp, cây còn có khả năng làm sạch không khí và tạo cảm giác thư thái, dễ chịu. Bàng Singapore thường được trưng bày trong phòng khách, sảnh khách sạn hoặc văn phòng để làm điểm nhấn xanh tươi.",
    temperatureAdvice: "Nhiệt độ lý tưởng: 20-30°C.",
    soilMoistureAdvice: "Để đất khô vừa phải giữa các lần tưới.",
    wateringCycleAdvice: "1-2 lần mỗi tuần.",
    lightAdvice: "Cây cần ánh sáng gián tiếp, tránh ánh sáng mạnh.",
    minHumidity: 30,
    maxHumidity: 80,
    potId: "gardenId2",
  ),
  Plant(
    id: 7,
    name: "Cây Lan Quân Tử",
    imageUrl: "lib/images/cay-lan-quan-tu.jpeg",
    description:
        "Cây Lan Quân Tử là biểu tượng của sự thanh cao, kiêu hãnh và thịnh vượng. Với hoa màu cam rực rỡ nổi bật trên nền lá xanh đậm, cây mang lại vẻ đẹp sang trọng và sức sống mạnh mẽ. Lan Quân Tử rất thích hợp để làm quà tặng trong các dịp đặc biệt như khai trương, tân gia hay kỷ niệm. Đặc biệt, cây còn có ý nghĩa phong thủy sâu sắc, mang đến sự thành công và may mắn cho gia chủ.",
    temperatureAdvice: "Nhiệt độ lý tưởng: 15-25°C.",
    soilMoistureAdvice: "Giữ đất hơi ẩm, không để đất quá khô.",
    wateringCycleAdvice:
        "2 lần mỗi tuần vào mùa hè, 1 lần mỗi tuần vào mùa đông.",
    lightAdvice: "Cây ưa ánh sáng nhẹ buổi sáng, tránh ánh nắng gắt.",
    minHumidity: 30,
    maxHumidity: 80,
    potId: "gardenId2",
  ),
  Plant(
    id: 8,
    name: "Cây Kim Ngân",
    imageUrl: "lib/images/cay-kim-ngan.jpeg",
    description:
        "Cây Kim Ngân không chỉ đẹp mà còn mang ý nghĩa phong thủy mạnh mẽ, tượng trưng cho sự giàu có, thịnh vượng và tài lộc. Cây có thân xoắn độc đáo, lá xanh mướt hình bàn tay, tạo cảm giác tươi mới và đầy sức sống. Với khả năng sống tốt trong điều kiện ánh sáng yếu, Kim Ngân rất phù hợp để đặt trong nhà, văn phòng hoặc quán cà phê. Đây cũng là loài cây thường được sử dụng làm quà tặng trong các dịp lễ quan trọng.",
    temperatureAdvice: "Nhiệt độ lý tưởng: 18-26°C.",
    soilMoistureAdvice: "Đất cần đủ ẩm nhưng không ngập nước.",
    wateringCycleAdvice: "1-2 lần mỗi tuần.",
    lightAdvice:
        "Cây cần ánh sáng tự nhiên, tránh ánh sáng trực tiếp quá mạnh.",
    minHumidity: 30,
    maxHumidity: 80,
    potId: "gardenId2",
  ),
  Plant(
    id: 9,
    name: "Cây Lan Ý",
    imageUrl: "lib/images/cay-lan-y.jpeg",
    description:
        "Cây Lan Ý không chỉ nổi bật với hoa trắng tinh khiết mà còn được yêu thích nhờ khả năng hấp thụ độc tố, cải thiện không khí trong nhà. Cây mang vẻ đẹp nhẹ nhàng, thanh lịch và biểu tượng của sự bình yên, hạnh phúc. Lan Ý thích hợp để trồng trong các không gian như phòng ngủ, phòng khách hoặc phòng làm việc, tạo không gian trong lành và dễ chịu.",
    temperatureAdvice: "Nhiệt độ lý tưởng: 20-30°C.",
    soilMoistureAdvice: "Giữ đất ẩm, không để khô lâu ngày.",
    wateringCycleAdvice: "2-3 lần mỗi tuần, tùy vào độ ẩm không khí.",
    lightAdvice: "Cây ưa ánh sáng nhẹ và bóng râm.",
    minHumidity: 30,
    potId: "gardenId2",
    maxHumidity: 80,
  ),
  Plant(
    id: 10,
    name: "Cây Tùng Bồng Lai",
    imageUrl: "lib/images/cay-tung-bong-lai.jpeg",
    description:
        "Cây Tùng Bồng Lai mang vẻ đẹp nhỏ nhắn nhưng đầy mạnh mẽ, biểu tượng của sự trường thọ, sức khỏe và bình an. Với tán lá dày đặc, xanh mướt, cây thường được dùng làm cây cảnh để bàn hoặc bonsai trang trí. Tùng Bồng Lai không chỉ giúp làm đẹp không gian mà còn tạo cảm giác thư giãn, gần gũi với thiên nhiên. Đây là lựa chọn tuyệt vời để làm quà tặng cho bạn bè và người thân.",
    temperatureAdvice: "Nhiệt độ lý tưởng: 15-25°C.",
    soilMoistureAdvice: "Giữ đất khô giữa các lần tưới, không để úng nước.",
    wateringCycleAdvice: "1 lần mỗi tuần, tùy thuộc vào độ ẩm không khí.",
    lightAdvice: "Cây thích ánh sáng tự nhiên, có thể chịu bóng râm.",
    minHumidity: 30,
    potId: "gardenId2",
    maxHumidity: 80,
  ),
];
