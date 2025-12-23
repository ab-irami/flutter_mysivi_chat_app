import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mysivi_chat_app/services/translator_services.dart';

part 'translation_state.dart';

class TranslationCubit extends Cubit<TranslationState> {
  final TranslatorServices _translator;

  TranslationCubit({TranslatorServices? translator})
    : _translator = translator ?? TranslatorServicesImpl.instance,
      super(TranslationInitial());

  Future<void> translateText(String text) async {
    if (isClosed) return;
    emit(TranslationLoading());
    try {
      final translatedText = await _translator.translateText(text);
      if (isClosed) return;
      emit(TranslationLoaded(translatedText));
    } catch (e) {
      if (isClosed) return;
      emit(TranslationError(e.toString()));
    }
  }
}
