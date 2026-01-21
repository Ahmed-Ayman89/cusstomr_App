import '../models/faq_model.dart';

class FaqRepository {
  List<FaqModel> getFaqs() {
    return [
      FaqModel(
        category: 'About Grow',
        question: 'What is Grow?',
        answer:
            'Grow is a simple, habit-building app that helps you make consistent progress through small daily actions. Each step you take earns points that you can track, celebrate, and use inside the app. Grow turns everyday moments into meaningful progress, making self-improvement feel effortless, motivating, and part of your routine.',
      ),
      FaqModel(
        category: 'About Grow',
        question: 'Does Grow have any physical stores?',
        answer:
            'No, Grow doesn’t have any physical stores. It’s a fully digital app, and all your actions happen online. If you ever need help, you can contact our team through the Contact section inside the app.',
      ),
      FaqModel(
        category: 'About Grow',
        question: 'What happened to my points?',
        answer:
            'Your points are always safe and stored in your Grow account. If you don’t see them, refresh the app. If the issue continues, contact our support team through the Contact section.',
      ),
      FaqModel(
        category: 'About Grow',
        question: 'What happens to my points if Grow shuts down?',
        answer:
            'If Grow ever shuts down, we will give you a warning beforehand and guide you on how to redeem your points. In the unlikely event that Grow closes without prior notice, we will reach out to make sure you can redeem your points in the best possible way.',
      ),
      FaqModel(
        category: 'About Grow',
        question:
            'How can I find the nearest and available verified stores to start saving points?',
        answer:
            'To find the nearest verified stores, open the Grow app, tap “Add Points,” then go to the “Verified Stores” section. You’ll see all available stores displayed on a map, with each store showing its own information. You can also tap “View Directions” to navigate directly to any store from the app.',
      ),
      FaqModel(
        category: 'About Grow',
        question: 'Can I add points by myself?',
        answer:
            'No, points can only be added through verified stores. This ensures that all points are earned securely and accurately.',
      ),
      FaqModel(
        category: 'About Grow',
        question: 'Does Grow plan to add more features in the future?',
        answer:
            'Yes! Grow is always evolving. We plan to add more features in the future to make the app even more helpful and engaging for our users. Your feedback also helps us decide what to build next.',
      ),
      FaqModel(
        category: 'About Grow',
        question: 'Can I use Grow without an internet connection?',
        answer:
            'Grow requires an internet connection to sync your points and goals. Some features may appear offline, but updates and point transfers need to be online.',
      ),
      FaqModel(
        category: 'About Grow',
        question: 'Is Grow available in multiple languages?',
        answer: 'Currently, Grow is available in English. ',
      ),
      // Saving Category
      FaqModel(
        category: 'Saving',
        question: 'Can I set more than one goal at a time?',
        answer:
            'Yes! You can set and track multiple goals at the same time in Grow. This lets you work on different objectives simultaneously while earning points and celebrating progress for each one.',
      ),
      FaqModel(
        category: 'Saving',
        question: 'What is the minimum amount required to start a goal?',
        answer:
            'There’s no minimum amount required to start a goal in Grow. You can begin with any small steps or points you have and build your progress gradually.',
      ),
      FaqModel(
        category: 'Saving',
        question: 'How can I add points to my goal?',
        answer:
            'To add points, open the Grow app, go to your Goals page, tap your goal, and then tap “Add Points.” You can transfer points from your main account or from any other goal.',
      ),
      FaqModel(
        category: 'Saving',
        question: 'How can I track my progress on my goal?',
        answer:
            'You can track your goal’s progress directly in the Grow app. Go to your Goals page, select your goal, and you’ll see a visual progress bar and detailed points history so you can monitor how close you are to achieving it.',
      ),
      FaqModel(
        category: 'Saving',
        question: 'Can I delete a goal?',
        answer:
            'You can delete a goal, but first you need to transfer its points to your main account or to another goal. Once the points are moved, you can safely delete the goal from your Goals page.',
      ),
      FaqModel(
        category: 'Saving',
        question: 'What happens if I don\'t add points for a long time?',
        answer:
            'Nothing will be lost. Your points and goals remain safe, and you can continue adding points whenever you\'re ready.',
      ),
      FaqModel(
        category: 'Saving',
        question: 'Can I rename my goals?',
        answer:
            'Yes, you can rename your goals at any time from the Goals page in the app.',
      ),

      // Redeem Category
      FaqModel(
        category: 'Redeem',
        question:
            'Are my points locked for the full duration of my goal, like a bank certificate?',
        answer:
            'No, your points aren\'t locked like a bank certificate. You can transfer points from a goal to your main account or to another goal at any time.',
      ),
      FaqModel(
        category: 'Redeem',
        question: 'What should I do to redeem my points?',
        answer:
            'To redeem your points, open the Grow app, go to your Goals or Main Account, and tap “Redeem.” Follow the steps in the app to choose how you want to use or transfer your points.',
      ),
      FaqModel(
        category: 'Redeem',
        question:
            'Can I redeem only part of my points, or do I need to redeem all at once?',
        answer:
            'You can redeem any portion of your points—you don\'t have to redeem everything at once.',
      ),
      FaqModel(
        category: 'Redeem',
        question: 'How long does it take for redeemed points to reflect?',
        answer:
            'Redeemed points are usually processed within 1 hour. In rare cases, it may take up to 2 days for updates to appear.',
      ),
      FaqModel(
        category: 'Redeem',
        question:
            'Are there any limits on how many points I can redeem at once?',
        answer:
            'No, you can redeem any portion of your points at a time, from part of your balance to all points.',
      ),
      FaqModel(
        category: 'Redeem',
        question: 'Can I transfer my points to another user?',
        answer:
            'Currently, points can only be used or transferred between your goals and main account. Direct transfers to other users are not supported.',
      ),

      // Register My Data Category
      FaqModel(
        category: 'Register',
        question: 'What are the requirements to start using Grow?',
        answer:
            'To start using Grow, you just need to download the app and create an account. You’ll need to provide some basic information during registration, such as your name and contact details.',
      ),
      FaqModel(
        category: 'Register',
        question: 'Can I change my registered phone number?',
        answer:
            'No, you cannot change your registered phone number directly in the app. If you need to update it, please contact our support team through the Contact section in the app.',
      ),
      FaqModel(
        category: 'Register',
        question: 'How do I delete my account?',
        answer:
            'You can delete your Grow account directly through the app. Go to your Profile or Account settings and select "Delete Account" to remove your account and data.',
      ),
      FaqModel(
        category: 'Register',
        question:
            'What should I do if I didn\'t receive my points in my account?',
        answer:
            'If you haven\'t received your points, first make sure your app is updated and synced. If the points still don\'t appear, contact our support team through the Contact section in the app, and we\'ll help resolve the issue.',
      ),
      FaqModel(
        category: 'Register',
        question: 'Is my personal data safe with Grow?',
        answer:
            'Yes! Your data is securely stored and handled according to privacy standards. We do not share your information with third parties without consent.',
      ),
      FaqModel(
        category: 'Register',
        question: 'Can I update other information besides my phone number?',
        answer:
            'Yes, you can update your profile details such as name directly in the app. For phone number changes, please contact our support team.',
      ),
      FaqModel(
        category: 'Register ',
        question: 'How does Grow use my data?',
        answer:
            'Grow uses your data to personalize your experience, track goals, manage points, and improve app features. We do not sell your data or use it for unrelated purposes.',
      ),
    ];
  }
}
