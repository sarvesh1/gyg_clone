import 'package:flutter/material.dart';

void main() {
  runApp(GetYourGuideApp());
}

class GetYourGuideApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GetYourGuide',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetYourGuide'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          SearchBar(),
          SizedBox(height: 16),
          CategoryTabs(),
          SizedBox(height: 16),
          RecentlySearched(),
          SizedBox(height: 16),
          RecommendedActivities(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {},
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  TravelPreferencesScreen(searchQuery: value)),
        );
      },
      decoration: InputDecoration(
        hintText: 'Search GetYourGuide',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}

class CategoryTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CategoryTab(icon: Icons.language, label: 'For you'),
        CategoryTab(icon: Icons.account_balance, label: 'Culture'),
        CategoryTab(icon: Icons.restaurant, label: 'Food'),
        CategoryTab(icon: Icons.nature, label: 'Nature'),
        CategoryTab(icon: Icons.sports, label: 'Sports'),
      ],
    );
  }
}

class CategoryTab extends StatelessWidget {
  final IconData icon;

  final String label;

  CategoryTab({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 30),
        Text(label),
      ],
    );
  }
}

class RecentlySearched extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recently searched', style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),
        Wrap(
          spacing: 8,
          children: [
            Chip(label: Text('Split')),
            Chip(label: Text('Day trips from')),
            Chip(label: Text('Stairway to Heaven')),
            Chip(label: Text('Gdansk')),
            Chip(label: Text('Sopot')),
            Chip(label: Text('Food & drinks')),
            Chip(label: Text('Berlin')),
          ],
        ),
      ],
    );
  }
}

class RecommendedActivities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Continue planning', style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),
        Container(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ActivityCard(
                imageUrl: 'https://placehold.co/600x400/000000/FFFFFF.jpg',
                title: 'Berlin: 1-Hour Segway Tour',
              ),
              ActivityCard(
                imageUrl: 'https://placehold.co/600x400/000000/FFFFFF.jpg',
                title: 'From Split: Plitvice Lakes Day Trip',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ActivityCard extends StatelessWidget {
  final String imageUrl;

  final String title;

  ActivityCard({required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(imageUrl, height: 120, width: 160, fit: BoxFit.cover),
          SizedBox(height: 10),
          Text(title, maxLines: 2, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

class TravelPreferencesScreen extends StatefulWidget {
  final String searchQuery;

  TravelPreferencesScreen({required this.searchQuery});

  @override
  _TravelPreferencesScreenState createState() =>
      _TravelPreferencesScreenState();
}

class _TravelPreferencesScreenState extends State<TravelPreferencesScreen> {
  final _formKey = GlobalKey<FormState>();

  String? tripType;

  int? numberOfPeople;

  DateTimeRange? dateRange;

  List<String> interests = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Preferences'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Type of trip'),
                items: ['Leisure', 'Business', 'Adventure']
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    tripType = value;
                  });
                },
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Number of people traveling'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    numberOfPeople = int.tryParse(value);
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Date range (YYYY-MM-DD to YYYY-MM-DD)'),
                onChanged: (value) {
                  setState(() {
                    dateRange = DateTimeRange(
                      start: DateTime.parse(value.split(' to ')[0]),
                      end: DateTime.parse(value.split(' to ')[1]),
                    );
                  });
                },
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Interests (comma separated)'),
                onChanged: (value) {
                  setState(() {
                    interests = value.split(',').map((e) => e.trim()).toList();
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _searchActivities();
                  }
                },
                child: Text('Search'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _searchActivities() {
    // Here you would call the GetYourGuide API with the captured preferences.

    // For now, we'll just print them to the console.

    print('Search Query: ${widget.searchQuery}');

    print('Trip Type: $tripType');

    print('Number of People: $numberOfPeople');

    print('Date Range: ${dateRange?.start} to ${dateRange?.end}');

    print('Interests: $interests');

    // Example API call (pseudo-code):

    print('https://travelers-api.getyourguide.com/search/v2/search?searchSource=3&sortBy=popularity&q=${widget.searchQuery}+$interests+$tripType&startDate=${dateRange?.start}&endDate=${dateRange?.end}');

    //   .then((response) => print(response.json()))
    

  }
}
