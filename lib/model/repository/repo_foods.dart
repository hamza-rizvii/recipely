import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipely/data_models/dm_categories.dart';
import 'package:recipely/data_models/dm_cuisines.dart';
import 'package:recipely/data_models/dm_foods.dart';

class RepositoryFoods {
  Future<List<DataModelFoods>> getFoods() async {
    List<DataModelFoods> list = [];
    QuerySnapshot? foodSnapshot =
        await FirebaseFirestore.instance.collection('food').get();
    if (foodSnapshot.docs.isNotEmpty) {
      for (var element in foodSnapshot.docs) {
        list.add(DataModelFoods(
            name: element['name'],
            categoryId: element['categoryId'],
            chef: element['chef'],
            cuisineId: element['cuisineId'],
            id: element['id']));
      }
    }
    return list;
  }

  Future<List<DataModelCategories>> getCategories() async {
    List<DataModelCategories> list = [];
    QuerySnapshot? foodSnapshot =
        await FirebaseFirestore.instance.collection('categories').get();
    if (foodSnapshot.docs.isNotEmpty) {
      for (var element in foodSnapshot.docs) {
        list.add(DataModelCategories(name: element['name'], id: element['id']));
      }
    }
    return list;
  }

  Future<List<DataModelCuisines>> getCuisines() async {
    List<DataModelCuisines> list = [];
    QuerySnapshot? foodSnapshot =
        await FirebaseFirestore.instance.collection('cuisine').get();
    if (foodSnapshot.docs.isNotEmpty) {
      for (var element in foodSnapshot.docs) {
        list.add(DataModelCuisines(name: element['name'], id: element['id']));
      }
    }
    return list;
  }
}
