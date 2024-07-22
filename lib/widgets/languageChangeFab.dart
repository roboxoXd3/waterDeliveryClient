// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheetal_raj_jal/controllers/languageController.dart';

class LanguageChangeFAB extends StatelessWidget {
  LanguageController controller;

  LanguageChangeFAB({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (controller.isExpanded.value)
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: controller.languages
                      .map((lang) => Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                controller.changeLanguage(lang);
                                controller.isExpanded.value = false;
                              },
                              child: Container(
                                width: 100,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.center,
                                child: Text(lang.toUpperCase()),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            FloatingActionButton(
              onPressed: () => controller.isExpanded.toggle(),
              backgroundColor: Colors.blue,
              child: Icon(
                  controller.isExpanded.value ? Icons.close : Icons.language),
            ),
          ],
        ));
  }
}
