import 'package:flutter/material.dart';
import 'package:recipely/utils/bloc_global/bloc_global.dart';
import 'package:recipely/utils/constants/my_constants.dart';
import 'package:recipely/viewmodel/search_screen/bloc_search_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    blocSearchScreen.viewModel.context = context;
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Colors.white,
      body: _body(context),
    );
  }

  _appBar() {
    return AppBar(
      title: const Text(
        'Search',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      elevation: 0,
    );
  }

  Widget _body(BuildContext context) {
    return StreamBuilder<Object>(
        stream: blocSearchScreen.stateStream,
        builder: (context, snapshot) {
          return blocSearchScreen.viewModel.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  child: Column(
                    children: [
                      _inputField(),
                      _list(),
                    ],
                  ),
                );
        });
  }

  _inputField() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        children: [
          //////////////////////////////////////////////////////////////////////
          /// SEARCH
          //////////////////////////////////////////////////////////////////////
          Expanded(
            child: TextField(
              controller: blocSearchScreen.searchController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  prefixIcon: const Icon(Icons.search_sharp),
                  hintText: 'Search...'),
              onChanged: (value) {
                blocSearchScreen.eventSink.add(EnumsSearchScreen.search);
              },
            ),
          ),
          //////////////////////////////////////////////////////////////////////
          /// FILTER
          //////////////////////////////////////////////////////////////////////
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
                color: MyConstants.splashScreenBackground,
                borderRadius: BorderRadius.circular(12.0)),
            child: IconButton(
              onPressed: () {
                blocSearchScreen.eventSink.add(EnumsSearchScreen.showFilters);
              },
              icon: const Icon(
                Icons.filter_list_alt,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  _list() {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: blocSearchScreen.viewModel.filteredFoodList.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 0.5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              margin: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                children: [
                  Container(
                    width: blocGlobal!.viewModel!.deviceWidth! * 0.2,
                    height: blocGlobal!.viewModel!.deviceWidth! * 0.2,
                    margin: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/$index.jpeg',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        blocSearchScreen.viewModel.filteredFoodList[index].name
                            .toString(),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person,
                              size: 14.0,
                            ),
                            Text(
                              blocSearchScreen
                                  .viewModel.filteredFoodList[index].chef
                                  .toString(),
                              style: const TextStyle(fontSize: 12.0),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
