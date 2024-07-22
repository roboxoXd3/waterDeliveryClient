import 'package:get/get.dart';

class FAQ {
  final String question;
  final String answer;

  FAQ({required this.question, required this.answer});
}

class HelpArticle {
  final String title;
  final String content;

  HelpArticle({required this.title, required this.content});
}

class SupportController extends GetxController {
  final RxList<FAQ> faqs = <FAQ>[
    FAQ(question: 'faq_question_1', answer: 'faq_answer_1'),
    FAQ(question: 'faq_question_2', answer: 'faq_answer_2'),
    FAQ(question: 'faq_question_3', answer: 'faq_answer_3'),
  ].obs;

  final RxList<HelpArticle> articles = <HelpArticle>[
    HelpArticle(title: 'article_title_1', content: 'article_content_1'),
    HelpArticle(title: 'article_title_2', content: 'article_content_2'),
    HelpArticle(title: 'article_title_3', content: 'article_content_3'),
  ].obs;

  final RxList<FAQ> filteredFAQs = <FAQ>[].obs;
  final RxList<HelpArticle> filteredArticles = <HelpArticle>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredFAQs.assignAll(faqs);
    filteredArticles.assignAll(articles);
  }

  void searchSupport(String query) {
    if (query.isEmpty) {
      filteredFAQs.assignAll(faqs);
      filteredArticles.assignAll(articles);
    } else {
      filteredFAQs.assignAll(faqs.where((faq) =>
          faq.question.tr.toLowerCase().contains(query.toLowerCase()) ||
          faq.answer.tr.toLowerCase().contains(query.toLowerCase())));
      filteredArticles.assignAll(articles.where((article) =>
          article.title.tr.toLowerCase().contains(query.toLowerCase()) ||
          article.content.tr.toLowerCase().contains(query.toLowerCase())));
    }
  }

  void openArticle(HelpArticle article) {
    // Implement article opening logic
    print('Opening article: ${article.title.tr}');
  }

  void reportIssue() {
    // Implement issue reporting logic
    print('Reporting issue');
  }

  void startLiveChat() {
    // Implement live chat logic
    print('Starting live chat');
  }
}
