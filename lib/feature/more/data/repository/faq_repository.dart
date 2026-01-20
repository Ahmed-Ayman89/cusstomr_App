import '../models/faq_model.dart';

class FaqRepository {
  List<FaqModel> getFaqs() {
    return [
      FaqModel(
        category: 'About Grow',
        question: 'What is Grow?',
        answer:
            'Grow is a savings app that helps you achieve your financial goals.',
      ),
      FaqModel(
        category: 'About Grow',
        question: 'Does Grow have any physical stores?',
        answer:
            'No, Grow is a fully digital platform accessible via our mobile app.',
      ),
      FaqModel(
        category: 'About Grow',
        question: 'What happened to my points?',
        answer:
            'Your points are stored safely in your wallet and can be redeemed or used for savings.',
      ),
      FaqModel(
        category: 'About Grow',
        question: 'What happens to my points if Grow shuts down?',
        answer:
            'We ensure all user data and assets are backed up and protected according to regulations.',
      ),
      FaqModel(
        category: 'About Grow',
        question:
            'How can I find the nearest and available verified stores to start saving points?',
        answer:
            'You can use the store locator feature in the app to find nearby verified partners.',
      ),
      FaqModel(
        category: 'About Grow',
        question: 'Can I add points by myself?',
        answer:
            'Points are typically added through transactions or verified activities, not manually.',
      ),
      FaqModel(
        category: 'About Grow',
        question: 'Does Grow plan to add more features in the future?',
        answer:
            'Yes, we are constantly working on new features to improve your experience.',
      ),
      FaqModel(
        category: 'About Grow',
        question: 'Can I use Grow without an internet connection?',
        answer:
            'An internet connection is required for most features to sync your data securely.',
      ),
      FaqModel(
        category: 'About Grow',
        question: 'Is Grow available in multiple languages?',
        answer: 'Currently we support English and Arabic.',
      ),
      // Saving Category Placeholders
      FaqModel(
        category: 'Saving',
        question: 'How do I start saving?',
        answer:
            'Create a space and start depositing money or points towards your goal.',
      ),
      FaqModel(
        category: 'Redeem',
        question: 'How do I redeem points?',
        answer:
            'Go to the rewards section and choose a reward to redeem with your points.',
      ),
    ];
  }
}
