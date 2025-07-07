
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_learning/example2/planet.dart';

import 'moon.dart';

class DataBase {
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'planets.db'),
      version: 1,
        onCreate: (Database db, int version) async {
          // Enable foreign key constraints (important in SQLite)
          await db.execute("PRAGMA foreign_keys = ON");
          await db.execute
            ('''CREATE TABLE IF NOT EXISTS planets(
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            age INTEGER NOT NULL,
            distancefromsun INTEGER NOT NULL)''');
          // Create moons table with foreign key referencing planets.id
          await db.execute
            ('''CREATE TABLE IF NOT EXISTS moons(
            moon_id INTEGER PRIMARY KEY AUTOINCREMENT,
            moon_name TEXT NOT NULL,
            planet_id INTEGER,
            FOREIGN KEY (planet_id) REFERENCES planets(id) ON DELETE CASCADE)''');
        }
    );
  }
  Future<int> insertMoon(Moon moon) async {
    final db = await initializedDB();
    return await db.insert('moons', moon.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Moon>> getMoons() async {
    final db = await initializedDB();
    final result = await db.query('moons');
    return result.map((e) => Moon.fromMap(e)).toList();
  }

  // insert data
  Future<int> insertPlanets(List<Planets> planets) async {
    int result = 0;
    final Database db = await initializedDB();
    for (var planet in planets) {
      result = await db.insert('planets', planet.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    return result;
  }

  // retrieve data
  Future<List<Planets>> retrievePlanets() async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult = await db.query('planets');
    return queryResult.map((e) => Planets.fromMap(e)).toList();
  }

  // delete user
  Future<void> deletePlanet(int id) async {
    final db = await initializedDB();
    await db.delete(
      'planets',
      where: "id = ?",
      whereArgs: [id],
    );
  }
  // update data
  Future<void> updatePlanet(Planets planet) async {
    final db = await initializedDB();
    await db.update(
      'planets',
      planet.toMap(),
      where: "id = ?",
      whereArgs: [planet.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

}