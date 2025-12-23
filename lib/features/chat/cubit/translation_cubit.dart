import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mysivi_chat_app/services/translator_services.dart';

part 'translation_state.dart';

class TranslationCubit extends Cubit<TranslationState> {
  final TranslatorServicesImpl _translator = TranslatorServicesImpl();

  TranslationCubit() : super(TranslationInitial());

  Future<void> translateText(String text) async {
    emit(TranslationLoading());
    try {
      final translatedText = await _translator.translateText(text);
      print("Translated text: $translatedText");
      emit(TranslationLoaded(translatedText));
    } catch (e) {
      emit(TranslationInitial());
    }
  }
}
