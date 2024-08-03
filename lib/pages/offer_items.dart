import 'package:flutter/material.dart';
import 'package:video_list/pages/get_text_label.dart';
import 'package:video_list/pages/offer_item.dart';

class OfferItems extends StatefulWidget {
  const OfferItems({super.key});

  @override
  State<OfferItems> createState() => _OfferItemsState();
}

//https://images.pexels.com/photos/1337384/pexels-photo-1337384.jpeg

class _OfferItemsState extends State<OfferItems> {
  final List _offer_items = [
    [
      "https://images.pexels.com/photos/1337384/pexels-photo-1337384.jpeg",
      "Graphics Designer",
      "GOED.MMC",
      "Design and create engaging graphics for various social media platforms (Facebook, Instagram, Twitter, LinkedIn, etc.). Develop and maintain a consistent visual style and brand identity across all social media channels. Collaborate with the marketing team to create graphics for campaigns, promotions, and other marketing materials. Stay up-to-date with the latest design trends and social media best practices. Manage multiple projects simultaneously while meeting deadlines. Create stories for social media. Provide creative input and contribute ideas for social media strategies and campaigns.",
    ],
    [
      "https://images.pexels.com/photos/1337384/pexels-photo-1337384.jpeg",
      "WordPress Expertise",
      "GOED.MMC",
      "Design and develop responsive websites using WordPress. Customize WordPress themes and plugins to meet project requirements. Ensure the website design is visually appealing, user-friendly, and aligns with brand guidelines. Collaborate with the marketing team to create and implement design elements that enhance user experience. Maintain and update existing websites, ensuring they are optimized for performance and security. Troubleshoot and resolve website issues as they arise. Stay up to date with the latest web design trends, tools, and technologies."
    ],
    [
      "https://images.pexels.com/photos/1337384/pexels-photo-1337384.jpeg",
      "Head of Data Technology",
      "GOED.MMC",
      "Leads the full product management lifecycle of a new suite of technologies and oversees the team responsible for delivering it. This high-profile role involves working with business leaders and partners across the organization, including C-level executives. Strong business and technology experience in the finance and/or retail domain is essential for success; Oversees the data technology roadmaps of assets and drives the adoption of cutting-edge technologies across the Group, aligned with the enablement mission of the PASHA Holding Data Office; Utilizes experience in Agile organizations to lead, develop, and inspire an Agile delivery team of data engineers, architects, devops engineers’ data operations engineers and data analysts. Foster a culture of innovation and excellence. Mentors and develops data technology team members. Develops and manages the Holding’s data technology roadmap, including requirements, resources, time, cost, quality, risks, and communications, ensuring alignment with the strategic objectives of companies within the Group;",
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _offer_items.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(25),
          child: OfferItem(
            logo: _offer_items[index][0],
            tittle: _offer_items[index][1],
            employer: _offer_items[index][2],
            description: _offer_items[index][3],
          ),
        );
      }
    );
  }
}
