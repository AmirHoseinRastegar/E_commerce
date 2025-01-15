import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/carousel_model.dart';

abstract class CarouselDataSource{
  Future<List<CarouselModel>> fetchCarousel();
}


class CarouselDataSourceImpl implements CarouselDataSource{
  final FirebaseFirestore db;

  CarouselDataSourceImpl({required this.db});
  @override
  Future<List<CarouselModel>> fetchCarousel() async{
    try{
      final data= await db.collection('carousel').get();
      return data.docs.map((e) {

        return CarouselModel.fromJson(e.data());
      }).toList();

    }catch(e){
      throw Exception('FAILED TO FETCH CAROUSELS : $e');
    }
  }

}