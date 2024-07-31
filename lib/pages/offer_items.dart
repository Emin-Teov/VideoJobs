import 'package:flutter/material.dart';
import 'package:video_list/pages/get_text_label.dart';

class Offer_Items extends StatefulWidget {
  const Offer_Items({super.key});

  @override
  State<Offer_Items> createState() => _Offer_ItemsState();
}

class _Offer_ItemsState extends State<Offer_Items> {
  final List _offer_items = [
    [
      "Graphics Designer",
      "JS.MMC",
      "Design and create engaging graphics for various social media platforms (Facebook, Instagram, Twitter, LinkedIn, etc.). Develop and maintain a consistent visual style and brand identity across all social media channels. Collaborate with the marketing team to create graphics for campaigns, promotions, and other marketing materials. Stay up-to-date with the latest design trends and social media best practices. Manage multiple projects simultaneously while meeting deadlines. Create stories for social media. Provide creative input and contribute ideas for social media strategies and campaigns.",
    ],
    [
      "WordPress Expertise",
      "JS.MMC",
      "Design and develop responsive websites using WordPress. Customize WordPress themes and plugins to meet project requirements. Ensure the website design is visually appealing, user-friendly, and aligns with brand guidelines. Collaborate with the marketing team to create and implement design elements that enhance user experience. Maintain and update existing websites, ensuring they are optimized for performance and security. Troubleshoot and resolve website issues as they arise. Stay up to date with the latest web design trends, tools, and technologies."
    ],
    [
      "Head of Data Technology",
      "JS.MMC",
      "Leads the full product management lifecycle of a new suite of technologies and oversees the team responsible for delivering it. This high-profile role involves working with business leaders and partners across the organization, including C-level executives. Strong business and technology experience in the finance and/or retail domain is essential for success; Oversees the data technology roadmaps of assets and drives the adoption of cutting-edge technologies across the Group, aligned with the enablement mission of the PASHA Holding Data Office; Utilizes experience in Agile organizations to lead, develop, and inspire an Agile delivery team of data engineers, architects, devops engineers’ data operations engineers and data analysts. Foster a culture of innovation and excellence. Mentors and develops data technology team members. Develops and manages the Holding’s data technology roadmap, including requirements, resources, time, cost, quality, risks, and communications, ensuring alignment with the strategic objectives of companies within the Group;",
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _offer_items.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GetTextLabel(head: 'Job title', value: _offer_items[index][0]),
            GetTextLabel(head: 'Company', value: _offer_items[index][1]),
            // GetTextLabel(head: 'Job description', value: _offer_items[index][2]),
          ],
        );
      }
    );
  }
}
