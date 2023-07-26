import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/data_providers/characters_repository.dart';
import '../data/models/characters.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository _charactersRepository;
  List<Character> _characters = [];
  CharactersCubit(this._charactersRepository) : super(CharactersInitial());

  List<Character> characters() {
    _charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      _characters = characters;
    });

    return _characters;
  }
}
