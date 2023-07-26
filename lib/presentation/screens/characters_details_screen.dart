import 'package:flutter/material.dart';
import '../../constants/mycolors.dart';

import '../../data/models/characters.dart';

class CharacterDetails extends StatelessWidget {
  final Character character;
  const CharacterDetails({super.key, required this.character});
  Widget buildSliverAppBar() {
    return SliverAppBar(
        expandedHeight: 500,
        pinned: true,
        stretch: true,
        backgroundColor: MyColors.myGrey,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Container(
            padding: const EdgeInsetsDirectional.all(5),
            decoration: BoxDecoration(
              color: MyColors.myGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              character.name!,
              style: const TextStyle(
                color: MyColors.myWhite,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          background: Hero(
            tag: character.id!,
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
        ));
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
          text: "$title : ",
          style: const TextStyle(
            color: MyColors.myWhite,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: value,
          style: const TextStyle(
            color: MyColors.myWhite,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ]),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
        height: 30,
        color: MyColors.myYellow,
        endIndent: endIndent,
        thickness: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: const EdgeInsetsDirectional.fromSTEB(14, 14, 14, 0),
              padding: const EdgeInsetsDirectional.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  characterInfo("Species", character.species ?? "Not Found"),
                  buildDivider(270),
                  characterInfo("Status", character.status ?? "Not Found"),
                  buildDivider(280),
                  characterInfo("Gender", character.gender ?? "Not Found"),
                  buildDivider(280),
                  characterInfo(
                      "Origin", character.origin!.name ?? "Not Found"),
                  buildDivider(280),
                  if (character.type != null && character.type!.isNotEmpty) ...{
                    characterInfo("Type", character.type ?? "Not Found"),
                    buildDivider(290),
                  },
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 500,
            )
          ]))
        ],
      ),
    );
  }
}
