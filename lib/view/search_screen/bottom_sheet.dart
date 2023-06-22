import 'package:flutter/material.dart';
import 'package:recipely/utils/bloc_global/bloc_global.dart';
import 'package:recipely/utils/constants/my_constants.dart';
import 'package:recipely/viewmodel/search_screen/bloc_search_screen.dart';
import 'package:recipely/viewmodel/search_screen/vm_search_screen.dart';

class FiltersBottomSheet extends StatefulWidget {
  FiltersBottomSheet({super.key});

  @override
  State<FiltersBottomSheet> createState() => _FiltersBottomSheetState();
}

class _FiltersBottomSheetState extends State<FiltersBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Column(
        children: [
          const Text(
            'Filters',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Categories',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                ),

                /// CATEGORIES
                GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2.0,
                    ),
                    itemCount: blocSearchScreen.viewModel.categoriesList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(12.0),
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (blocSearchScreen
                                    .viewModel.appliedCategoriesFilterList
                                    .contains(
                                  int.parse(
                                    blocSearchScreen
                                        .viewModel.categoriesList[index].id
                                        .toString(),
                                  ),
                                )) {
                                  blocSearchScreen
                                      .viewModel.appliedCategoriesFilterList
                                      .remove(int.parse(
                                    blocSearchScreen
                                        .viewModel.categoriesList[index].id
                                        .toString(),
                                  ));
                                } else {
                                  blocSearchScreen
                                      .viewModel.appliedCategoriesFilterList
                                      .add(
                                    int.parse(
                                      blocSearchScreen
                                          .viewModel.categoriesList[index].id
                                          .toString(),
                                    ),
                                  );
                                }
                              });
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    blocSearchScreen.viewModel
                                            .appliedCategoriesFilterList
                                            .contains(int.parse(blocSearchScreen
                                                .viewModel
                                                .categoriesList[index]
                                                .id
                                                .toString()))
                                        ? MyConstants.splashScreenBackground
                                        : Colors.black)),
                            child: Text(blocSearchScreen
                                .viewModel.categoriesList[index].name
                                .toString())),
                      );
                    }),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Cuisines',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                ),

                /// CUISINES
                GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2.0,
                    ),
                    itemCount: blocSearchScreen.viewModel.cuisinesList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(12.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (blocSearchScreen
                                  .viewModel.appliedCuisineFilterList
                                  .contains(
                                int.parse(
                                  blocSearchScreen
                                      .viewModel.cuisinesList[index].id
                                      .toString(),
                                ),
                              )) {
                                blocSearchScreen
                                    .viewModel.appliedCuisineFilterList
                                    .remove(int.parse(
                                  blocSearchScreen
                                      .viewModel.cuisinesList[index].id
                                      .toString(),
                                ));
                              } else {
                                blocSearchScreen
                                    .viewModel.appliedCuisineFilterList
                                    .add(
                                  int.parse(
                                    blocSearchScreen
                                        .viewModel.cuisinesList[index].id
                                        .toString(),
                                  ),
                                );
                              }
                            });
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  blocSearchScreen
                                          .viewModel.appliedCuisineFilterList
                                          .contains(int.parse(blocSearchScreen
                                              .viewModel.cuisinesList[index].id
                                              .toString()))
                                      ? MyConstants.splashScreenBackground
                                      : Colors.black)),
                          child: Text(
                            blocSearchScreen.viewModel.cuisinesList[index].name
                                .toString(),
                            style: const TextStyle(fontSize: 12.0),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
          Container(
            margin:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            width: blocGlobal!.viewModel!.deviceWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.black,
            ),
            child: ElevatedButton(
              onPressed: () {
                blocSearchScreen.applyFilters();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Apply Filters',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: TextButton(
              onPressed: () {
                setState(() {
                  blocSearchScreen.clearFilters();
                  Navigator.of(context).pop();
                });
              },
              child: const Text('Clear Filters'),
            ),
          ),
        ],
      ),
    );
  }
}
