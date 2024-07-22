import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/supportController.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupportController>(
        init: SupportController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text('support'.tr,
                  style: GoogleFonts.poppins(color: Colors.black)),
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.blue),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchBar(controller),
                    const SizedBox(height: 20),
                    _buildFAQSection(controller),
                    const SizedBox(height: 20),
                    _buildContactUsSection(),
                    const SizedBox(height: 20),
                    _buildHelpArticlesSection(controller),
                    const SizedBox(height: 20),
                    _buildReportIssueButton(controller),
                  ],
                ),
              ),
            ),
            floatingActionButton: _buildLiveChatButton(controller),
          );
        });
  }

  Widget _buildSearchBar(SupportController controller) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'search_support'.tr,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onChanged: controller.searchSupport,
    );
  }

  Widget _buildFAQSection(SupportController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'faq'.tr,
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Obx(() => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.filteredFAQs.length,
              itemBuilder: (context, index) {
                final faq = controller.filteredFAQs[index];
                return ExpansionTile(
                  title: Text(faq.question.tr, style: GoogleFonts.poppins()),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(faq.answer.tr, style: GoogleFonts.poppins()),
                    ),
                  ],
                );
              },
            )),
      ],
    );
  }

  Widget _buildContactUsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'contact_us'.tr,
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: const Icon(Icons.phone),
          title: Text('phone'.tr, style: GoogleFonts.poppins()),
          subtitle: Text('+91 1234567890', style: GoogleFonts.poppins()),
        ),
        ListTile(
          leading: const Icon(Icons.email),
          title: Text('email'.tr, style: GoogleFonts.poppins()),
          subtitle:
              Text('support@rajsheetaljal.com', style: GoogleFonts.poppins()),
        ),
      ],
    );
  }

  Widget _buildHelpArticlesSection(SupportController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'help_articles'.tr,
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Obx(() => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.filteredArticles.length,
              itemBuilder: (context, index) {
                final article = controller.filteredArticles[index];
                return ListTile(
                  title: Text(article.title.tr, style: GoogleFonts.poppins()),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => controller.openArticle(article),
                );
              },
            )),
      ],
    );
  }

  Widget _buildReportIssueButton(SupportController controller) {
    return ElevatedButton(
      onPressed: controller.reportIssue,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text('report_issue'.tr, style: GoogleFonts.poppins()),
    );
  }

  Widget _buildLiveChatButton(SupportController controller) {
    return FloatingActionButton(
      onPressed: controller.startLiveChat,
      backgroundColor: Colors.blue,
      child: const Icon(Icons.chat),
    );
  }
}
