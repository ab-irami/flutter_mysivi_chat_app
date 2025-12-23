import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_mysivi_chat_app/features/chat/cubit/translation_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/mock_helpers.dart';

void main() {
  late TranslationCubit cubit;
  late MockTranslatorServices mockTranslator;

  setUp(() {
    mockTranslator = MockTranslatorServices();
    cubit = TranslationCubit(translator: mockTranslator);
  });

  tearDown(() => cubit.close());

  blocTest<TranslationCubit, TranslationState>(
    'emits loading then translated text',
    build: () {
      when(
        () => mockTranslator.translateText('hello'),
      ).thenAnswer((_) async => 'bonjour');
      return cubit;
    },
    act: (cubit) => cubit.translateText('hello'),
    expect: () => [
      isA<TranslationLoading>(),
      isA<TranslationLoaded>().having(
        (s) => s.translatedText,
        'text',
        'bonjour',
      ),
    ],
  );
}
