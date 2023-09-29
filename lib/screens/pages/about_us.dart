import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Developer> developers = [
      Developer(
        name: 'John Doe',
        description: 'Flutter Developer',
        imageAsset: 'assets/image1.png', // Replace with actual image path
      ),
      Developer(
        name: 'Jane Smith',
        description: 'UI/UX Designer',
        imageAsset: 'assets/image2.png', // Replace with actual image path
      ),
      // Add more developers here
    ];

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

class Developer {
  final String name;
  final String description;
  final String imageAsset;

  Developer({
    required this.name,
    required this.description,
    required this.imageAsset,
  });
}

class DeveloperCard extends StatelessWidget {
  final Developer developer;

  const DeveloperCard({super.key, required this.developer});

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
