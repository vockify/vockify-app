import 'package:json_annotation/json_annotation.dart';

enum PartOfSpeech {
  @JsonValue('noun')
  Noun,
  @JsonValue('pronoun')
  Pronoun,
  @JsonValue('verb')
  Verb,
  @JsonValue('adjective')
  Adjective,
  @JsonValue('adverb')
  Adverb,
  @JsonValue('preposition')
  Preposition,
  @JsonValue('conjunction')
  Conjunction,
  @JsonValue('interjection')
  Interjection,
  @JsonValue('participle')
  Participle,
}
