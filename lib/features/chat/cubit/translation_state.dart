part of 'translation_cubit.dart';

@immutable
sealed class TranslationState {}

final class TranslationInitial extends TranslationState {}

final class TranslationLoading extends TranslationState {}

final class TranslationLoaded extends TranslationState {
  final String translatedText;

  TranslationLoaded(this.translatedText);
}