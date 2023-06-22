import 'package:flutter/material.dart';
import 'package:recipely/utils/bloc_global/bloc_global.dart';
import 'package:recipely/viewmodel/search_screen/bloc_search_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  late BlocSearchScreen bloc;

  @override
  Widget build(BuildContext context) {
    // INIT BLOC
    bloc = BlocSearchScreen(context: context);

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
        stream: bloc.stateStream,
        builder: (context, snapshot) {
          return bloc.viewModel.isLoading
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
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      curve: Curves.ease,
      width: bloc.viewModel.emailPasswordBoxWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: TextField(
          controller: bloc.searchController,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black12,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              prefixIcon: const Icon(Icons.search_sharp),
              hintText: 'Search...'),
        ),
      ),
    );
  }

  _list() {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: bloc.viewModel.foodSnapshot!.docs.length,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: const EdgeInsets.all(6.0),
              title: Text(
                  bloc.viewModel.foodSnapshot!.docs[index]['name'].toString()),
              subtitle: Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 14.0,
                  ),
                  Text(
                    bloc.viewModel.foodSnapshot!.docs[index]['chef'],
                    style: const TextStyle(fontSize: 12.0),
                  )
                ],
              ),
              leading: Image.asset(
                'assets/$index.jpeg',
                fit: BoxFit.fill,
                height: blocGlobal!.viewModel!.deviceHeight! * 0.1,
                width: blocGlobal!.viewModel!.deviceWidth! * 0.2,
              ),
            );
          }),
    );
  }
}
