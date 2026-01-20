import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repository/faq_repository.dart';
import 'faq_state.dart';

class FaqCubit extends Cubit<FaqState> {
  final FaqRepository _repository;

  FaqCubit(this._repository) : super(FaqInitial());

  void loadFaqs() {
    final faqs = _repository.getFaqs();
    emit(FaqLoaded(
      allFaqs: faqs,
      filteredFaqs: faqs.where((e) => e.category == 'About Grow').toList(),
      selectedCategory: 'About Grow',
    ));
  }

  void selectCategory(String category) {
    if (state is FaqLoaded) {
      final currentState = state as FaqLoaded;
      emit(FaqLoaded(
        allFaqs: currentState.allFaqs,
        filteredFaqs:
            currentState.allFaqs.where((e) => e.category == category).toList(),
        selectedCategory: category,
      ));
    }
  }
}
