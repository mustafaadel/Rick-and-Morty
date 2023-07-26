import 'package:flutter/material.dart';

import '../../constants/mycolors.dart';
import '../../constants/strings.dart';
import '../../data/models/characters.dart';

class CharacterItem extends StatelessWidget {
  final Character character;
  final int index;
  const CharacterItem(
      {super.key, required this.character, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, characterDetailsScreen,
              arguments: character);
        },
        child: GridTile(
            footer: Container(
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: GridTileBar(
                backgroundColor: MyColors.myGrey,
                title: Text(
                  character.name ?? "Not Found",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    height: 1.5,
                    color: MyColors.myWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
            child: Hero(
              tag: character.id!,
              child: Container(
                color: MyColors.myGrey,
                child: character.image!.isNotEmpty
                    ? Image.network(
                        character.image ?? "",
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "assets/images/450.jpg",
                        fit: BoxFit.cover,
                      ),
              ),
            )),
      ),
    );
  }
}
