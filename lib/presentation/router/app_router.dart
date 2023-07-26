import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/characters_cubit.dart';
import '../../data/data_providers/characters_repository.dart';
import '../../data/models/characters.dart';
import '../../data/network/characters_web_services.dart';
import '../screens/characters_screen.dart';

import '../../constants/strings.dart';
import '../screens/characters_details_screen.dart';

class AppRouter {
  late CharactersRepository _charactersRepository;
  late CharactersCubit _charactersCubit;

  AppRouter() {
    _charactersRepository = CharactersRepository(CharactersWebServices());
    _charactersCubit = CharactersCubit(_charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (_) => _charactersCubit,
                child: const CharactersScreen()));

      case characterDetailsScreen:
        final selectedCharacter = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => CharacterDetails(
                  character: selectedCharacter,
                ));

      default:
        return null;
    }
  }
}
