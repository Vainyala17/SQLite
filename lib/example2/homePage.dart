import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_learning/example2/planet.dart';

import 'database.dart';
import 'moon.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DataBase handler;

  Future<int> addPlanets() async {
    Planets firstPlanet = Planets(
      name: "Mercury",
      age: 24,
      id: 1,
      distancefromsun: 10,
    );
    Planets secondPlanet = Planets(
      name: "Venus",
      age: 31,
      id: 2,
      distancefromsun: 20,
    );
    Planets thirdPlanet = Planets(
      id: 3,
      name: 'Earth',
      age: 4,
      distancefromsun: 30,
    );
    Planets fourthPlanet = Planets(
      id: 4,
      name: 'Mars',
      age: 5,
      distancefromsun: 40,
    );

    List<Planets> planets = [
      firstPlanet,
      secondPlanet,
      thirdPlanet,
      fourthPlanet,
    ];
    return await handler.insertPlanets(planets);
  }

  Future<void> deletePlanet(int id) async {
    await handler.deletePlanet(id);
    setState(() {});
  }

  Future<void> editPlanet(Planets planet) async {
    await handler.updatePlanet(planet);
    setState(() {});
  }
  Future<List<Moon>> getMoonsByPlanetId(int planetId) async {
    List<Moon> allMoons = await handler.getMoons();
    return allMoons.where((moon) => moon.planetId == planetId).toList();
  }

  @override
  void initState() {
    super.initState();
    handler = DataBase();
    handler.initializedDB().whenComplete(() async {
      await addPlanets();
      await handler.insertMoon(Moon(moonName: "Moon 1", planetId: 1));
      await handler.insertMoon(Moon(moonName: "Moon 2", planetId: 3));
      await handler.insertMoon(Moon(moonName: "Phobos", planetId: 4));
      await handler.insertMoon(Moon(moonName: "Deimos", planetId: 4));

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Planets'),
          backgroundColor: const Color.fromARGB(255, 108, 38, 0),
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: handler.retrievePlanets(),
            builder: (
                BuildContext context,
                AsyncSnapshot<List<Planets>> snapshot,
                ) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    final planet = snapshot.data![index];

                    return FutureBuilder<List<Moon>>(
                      future: getMoonsByPlanetId(planet.id),
                      builder: (context, moonSnapshot) {
                        final moons = moonSnapshot.data ?? [];

                        return Card(
                          color: Colors.orange.shade100,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8.0),
                            title: Text(planet.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Age: ${planet.age}'),
                                Text('Distance from Sun: ${planet.distancefromsun}'),
                                if (moons.isNotEmpty)
                                  Text('Moons: ${moons.map((e) => e.moonName).join(', ')}'),
                                if (moons.isEmpty)
                                  Text('No moons', style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    editPlanet(Planets(
                                      id: planet.id,
                                      name: '${planet.name} Updated',
                                      age: planet.age,
                                      distancefromsun: planet.distancefromsun,
                                    ));
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    deletePlanet(planet.id);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 108, 38, 0),
          foregroundColor: Colors.white,
          onPressed: () async {
            // Example add: Add a new planet
            await handler.insertPlanets([
              Planets(
                id: DateTime.now().millisecondsSinceEpoch,
                name: 'New Planet',
                age: 1,
                distancefromsun: 50,
              ),
            ]);
            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}