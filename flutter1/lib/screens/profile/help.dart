import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  Future<List<List<dynamic>>>? _csvData;

  @override
  void initState() {
    super.initState();
    _csvData = loadCsv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Yardım',
          style: TextStyle(fontFamily: 'Sora', color: Colors.white),
        ),
        backgroundColor: Colors.black, // Arka plan siyah
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.black, // Arka plan siyah
        child: FutureBuilder<List<List<dynamic>>>(
          future: _csvData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Hata: ${snapshot.error}',
                      style:
                          TextStyle(fontFamily: 'Sora', color: Colors.white)));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                  child: Text('Veri bulunamadı.',
                      style:
                          TextStyle(fontFamily: 'Sora', color: Colors.white)));
            } else {
              final data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length - 1, // Başlık satırını atlamak için -1
                itemBuilder: (context, index) {
                  final row = data[index + 1]; // İlk satırı atlamak için +1
                  return ListTile(
                    title: Text(row[0].toString(),
                        style: TextStyle(
                            fontFamily: 'Sora', color: Colors.white)), // Soru
                    subtitle: Text(row[1].toString(),
                        style: TextStyle(
                            fontFamily: 'Sora', color: Colors.white)), // Cevap
                    tileColor: Colors.black, // Liste arka planı siyah
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<List<dynamic>>> loadCsv() async {
    final csvString = await rootBundle.loadString('assets/help.csv');
    List<List<dynamic>> csvData = CsvToListConverter().convert(csvString);
    return csvData;
  }
}
