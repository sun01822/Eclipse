import 'package:eclipse/data/developers.dart';
import 'package:eclipse/models/developer.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: developers.length,
          itemBuilder: (context, index) {
            return DeveloperCard(developer: developers[index]);
          },
        ),
      ),
    );
  }
}


class DeveloperCard extends StatelessWidget {
  final Developer developer;

  const DeveloperCard({Key? key, required this.developer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50.0,
            backgroundImage: AssetImage(developer.imageAsset),
          ),
          const SizedBox(height: 10.0),
          Text(
            developer.name,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(developer.description),
        ],
      ),
    );
  }
}
