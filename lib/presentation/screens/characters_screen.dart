import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../business_logic/characters_cubit.dart';
import '../../constants/mycolors.dart';
import '../widget/character_item.dart';

import '../../data/models/characters.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters = [];
  late List<Character> searchedCharacters = [];
  bool isSearching = false;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).characters();
  }

  Widget buildSearchField() {
    return TextField(
        controller: _searchController,
        cursorColor: MyColors.black,
        style: const TextStyle(color: MyColors.black, fontSize: 18),
        decoration: const InputDecoration(
          hintText: "Search for a character...",
          border: InputBorder.none,
          hintStyle: TextStyle(color: MyColors.black, fontSize: 18),
        ),
        onChanged: (value) {
          addSearchedCharacters(value);
        });
  }

  void addSearchedCharacters(String value) {
    searchedCharacters = allCharacters
        .where((character) =>
            character.name!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {});
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            _stopSearch();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            _search();
          },
          icon: const Icon(Icons.search),
        ),
      ];
    }
  }

  void _search() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));

    setState(() {
      isSearching = true;
    });
  }

  void _stopSearch() {
    _clearSearch();

    setState(() {
      isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      addSearchedCharacters("");
    });
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = state.characters;
          return buildLoadedListWidgets();
        } else if (state is CharactersError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: MyColors.myYellow,
            ),
          );
        }
      },
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemBuilder: (context, index) {
        return CharacterItem(
          character:
              isSearching ? searchedCharacters[index] : allCharacters[index],
          index: index,
        );
      },
      itemCount: isSearching ? searchedCharacters.length : allCharacters.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
    );
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'Characters',
      style: TextStyle(
        color: MyColors.myGrey,
      ),
    );
  }

  Widget buildNoConnectionWidget() {
    return const Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "No Internet Connection",
              style: TextStyle(
                  color: MyColors.myGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Image(
                height: 200,
                width: 200,
                image: AssetImage("assets/images/no-wifi.png"))
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: isSearching ? buildSearchField() : _buildAppBarTitle(),
        actions: [
          ...buildAppBarActions(),
        ],
      ),
      body: OfflineBuilder(
          connectivityBuilder: (context, value, child) {
            final bool connected = value != ConnectivityResult.none;
            if (connected) {
              return buildBlocWidget();
            } else {
              return buildNoConnectionWidget();
            }
          },
          child: const Center(
            child: CircularProgressIndicator(
              color: MyColors.myYellow,
            ),
          )),
    );
  }
}
