import 'package:flutter/material.dart';
import 'package:recipely/data_models/dm_categories.dart';
import 'package:recipely/data_models/dm_cuisines.dart';
import 'package:recipely/data_models/dm_foods.dart';

class ViewModelSearchScreen {
  late BuildContext context;

  double emailPasswordBoxWidth = 0;
  double loginButtonWidth = 0;
  double socialButtonsWidth = 0;
  bool isLoading = false;
  bool isCategoriesLoading = false;

  /// LISTS
  List<DataModelFoods> foodsList = [];
  List<DataModelFoods> filteredFoodList = [];
  List<DataModelCategories> categoriesList = [];
  List<DataModelCuisines> cuisinesList = [];

  /// FILTERS
  List<int> appliedCategoriesFilterList = [];
  List<int> appliedCuisineFilterList = [];
}
