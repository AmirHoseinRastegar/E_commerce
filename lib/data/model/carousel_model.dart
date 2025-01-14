class CarouselModel{
  final String bannerImage;

  CarouselModel({required this.bannerImage});


  CarouselModel.fromJson(Map<String, dynamic> json)
      : bannerImage = json['banner'];
}