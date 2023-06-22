import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recipely/data_models/dm_categories.dart';
import 'package:recipely/data_models/dm_cuisines.dart';
import 'package:recipely/data_models/dm_foods.dart';
import 'package:recipely/model/repository/repo_foods.dart';
import 'package:recipely/view/search_screen/bottom_sheet.dart';
import 'vm_search_screen.dart';

enum EnumsSearchScreen { update, search, showFilters }

class BlocSearchScreen {
  late ViewModelSearchScreen viewModel;

  //////////////////////////////////////////////////////////////////////////////
  // EMAIL CONTROLLER
  TextEditingController searchController = TextEditingController();

  //////////////////////////////////////////////////////////////////////////////

  /// State Controller
  final _stateController = StreamController<Object>.broadcast();

  StreamSink<Object> get _stateSink => _stateController.sink;

  Stream<Object> get stateStream => _stateController.stream;

  /// Event Controller
  final _eventController = StreamController<EnumsSearchScreen>();

  StreamSink<EnumsSearchScreen> get eventSink => _eventController.sink;

  /// CONSTRUCTOR
  BlocSearchScreen() {
    /// INITIALIZING VIEW MODEL
    viewModel = ViewModelSearchScreen();

    /// GET DATA FROM FIRE STORE
    _getFoodsList();

    /// Listening to events
    _eventController.stream.listen((event) {
      switch (event) {
        case EnumsSearchScreen.update:
          _update();
          break;
        case EnumsSearchScreen.search:
          _search();
          break;
        case EnumsSearchScreen.showFilters:
          _showBottomSheet();
          break;
      }
    });
  }

  _update() {
    _stateSink.add(Object);
  }

  _getFoodsList() async {
    viewModel.isLoading = true;
    _update();
    try {
      viewModel.foodsList = await RepositoryFoods().getFoods();
      viewModel.filteredFoodList = viewModel.foodsList;
    } catch (e) {
      _showErrorDialog(msg: e.toString());
    }
    viewModel.isLoading = false;
    _update();
  }

  _showErrorDialog({required String msg}) {
    showDialog(
        context: viewModel.context,
        builder: (context) {
          return AlertDialog(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Authentication Error'),
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                )
              ],
            ),
            content: Text(msg),
          );
        });
  }

  _getCategories() async {
    viewModel.isCategoriesLoading = true;
    _update();
    try {
      viewModel.categoriesList =
          (await RepositoryFoods().getCategories()).cast<DataModelCategories>();
      viewModel.cuisinesList =
          (await RepositoryFoods().getCuisines()).cast<DataModelCuisines>();
    } catch (e) {
      _showErrorDialog(msg: e.toString());
    }
    viewModel.isCategoriesLoading = false;
    _update();
  }

  _showBottomSheet() {
    showModalBottomSheet(
        context: viewModel.context,
        builder: (BuildContext context) {
          return FutureBuilder(
            future: _getCategories(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return FiltersBottomSheet();
            },
          );
        });
  }

  applyFilters() {
    List<DataModelFoods> newList = [];

    /// CATEGORIES
    for (var food in viewModel.foodsList) {
      for (int categoryId in viewModel.appliedCategoriesFilterList) {
        if (food.categoryId.toString().contains(categoryId.toString())) {
          newList.add(food);
        }
      }
    }

    /// CUISINES
    for (var food in viewModel.foodsList) {
      for (int cuisineId in viewModel.appliedCuisineFilterList) {
        if (food.cuisineId.toString().contains(cuisineId.toString())) {
          if (!newList.contains(food)) {
            newList.add(food);
          }
        }
      }
    }
    viewModel.filteredFoodList = newList;
    _update();
  }

  clearFilters() {
    viewModel.appliedCategoriesFilterList.clear();
    viewModel.appliedCuisineFilterList.clear();
    viewModel.foodsList.clear();
    viewModel.filteredFoodList.clear();
    _getFoodsList();
    _update();
  }

  _search() {
    List<DataModelFoods> newList = [];

    /// CATEGORIES
    for (var food in viewModel.foodsList) {
      if (food.name
          .toString()
          .toUpperCase()
          .contains(searchController.text.toString().toUpperCase())) {
        newList.add(food);
      }
    }
    viewModel.filteredFoodList = newList;
    _update();
  }
}

BlocSearchScreen blocSearchScreen = BlocSearchScreen();
