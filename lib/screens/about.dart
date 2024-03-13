import 'package:flutter/material.dart';
import 'package:project_ar/config/color_constants.dart';
import 'package:project_ar/config/text_styles.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  // Function for repeated list tile
  ListTile _buildListTile(IconData icon, String title, void Function() onTap) {
    return ListTile(
      leading: Icon(icon, color: ColorConstants.whiteColor),
      title: Text(title, style: CustomTextStyles.headingText3),
      onTap: onTap,
      trailing:
          const Icon(Icons.arrow_forward_ios_rounded, color: ColorConstants.whiteColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.blackColorBackground,
      appBar: AppBar(
        title: Text('About', style: CustomTextStyles.headingText1),
        backgroundColor: ColorConstants.blackColorBackground,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorConstants.whiteColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 40),
          // Premium Features using function
          _buildListTile(Icons.star, 'Premium Features', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PremiumFeaturesScreen()),
            );
          }),
          // Help using function
          _buildListTile(Icons.help, 'Help', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HelpScreen()),
            );
          }),
          const Divider(color: ColorConstants.whiteColor, thickness: 0.2, indent: 30, endIndent: 30, height: 0),
          // size box for spacing
          const SizedBox(height: 20),
          // 'imprint' using function
           _buildListTile(Icons.sunny, 'Imprint', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HelpScreen()),
            );
          }),
          // copy right using function
          _buildListTile(Icons.copyright_rounded, 'Copyright', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HelpScreen()),
            );
          }),
          // privacy policy using function
          _buildListTile(Icons.privacy_tip_rounded, 'Privacy', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HelpScreen()),
            );
          }),
          // source list using function
          _buildListTile(Icons.source_rounded, 'Source', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HelpScreen()),
            );
          }),
          // divider
          const Divider(color: ColorConstants.whiteColor, thickness: 0.2, indent: 30, endIndent: 30, height: 0),
          // size box for spacing
          const SizedBox(height: 20),
          // share app using function
          _buildListTile(Icons.share, 'Share App', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HelpScreen()),
            );
          }),
          // contact us using function
          _buildListTile(Icons.contact_support, 'Contact Us', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HelpScreen()),
            );
          }),
          // two logos at the bottom of the screen
          const SizedBox(height: 80),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.circle, size: 40, color: ColorConstants.whiteColor),
              SizedBox(width: 20),
              Icon(Icons.circle, size: 40, color: ColorConstants.whiteColor),
            ],
          ),
        ],
      ),
    );
  }
}

// Placeholder for PremiumFeaturesScreen temporary
class PremiumFeaturesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Premium Features')),
      // Your screen content here
    );
  }
}

// Placeholder for HelpScreen
class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Help')),
      // Your screen content here
    );
  }
}
