import '../data/models/faq_model.dart';

abstract class FaqState {}

class FaqInitial extends FaqState {}

class FaqLoaded extends FaqState {
  final List<FaqModel> allFaqs;
  final List<FaqModel> filteredFaqs;
  final String selectedCategory;

  FaqLoaded({
    required this.allFaqs,
    required this.filteredFaqs,
    required this.selectedCategory,
  });
}
