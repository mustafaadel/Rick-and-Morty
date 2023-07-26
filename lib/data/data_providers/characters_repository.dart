import '../models/characters.dart';
import '../network/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices _charactersWebServices;

  CharactersRepository(this._charactersWebServices);

  Future<List<Character>> getAllCharacters() async {
    final characters = await _charactersWebServices.getAllCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }
}
