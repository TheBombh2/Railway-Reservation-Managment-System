import 'package:flutter/material.dart';

class StationSelectionScreen extends StatefulWidget {
  @override
  _StationSelectionScreenState createState() => _StationSelectionScreenState();
}

class _StationSelectionScreenState extends State<StationSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> allStations = [
    'Abanpola',
    'Agbopura',
    'Ahungalle',
    'Akurala',
    'Alawwa',
    'Alawathupitiya',
    'Aluthgama',
    'Ambalangoda',
    'Ambeputhsa',
    'Badulla',
    'Balapitiya',
    'Babarenda',
    'Bambalapitiya',
    'Bandarawela',
    'Bangadeniya',
    'Batticaloa',
    'Batuwatta',
    'Chavakachcheri',
    'Colombo Fort',
  ];

  List<String> filteredStations = [];

  @override
  void initState() {
    super.initState();
    filteredStations = allStations;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      filteredStations =
          allStations
              .where(
                (station) => station.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                ),
              )
              .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Color(0xff0076CB)),
        title: Text(
          'Stations',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xff0076CB),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                suffixIcon: Icon(Icons.search, color: Color(0xff0076CB)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  
                  
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Color(0xffFFFBFB)),
                child: ListView.builder(
                  itemCount: filteredStations.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        filteredStations[index],
                        style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
