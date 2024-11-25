// lib/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/appointment.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    var dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, 'appointments.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE appointments (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            customerName TEXT,
            company TEXT,
            description TEXT,
            appointmentDate TEXT,
            location TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertAppointment(Appointment appointment) async {
    final db = await database;
    await db.insert('appointments', appointment.toJson());
  }

  Future<List<Appointment>> fetchAppointments() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('appointments');
    return List.generate(result.length, (i) {
      return Appointment.fromJson(result[i]);
    });
  }

  Future<void> updateAppointment(Appointment appointment) async {
    final db = await database;
    await db.update(
      'appointments',
      appointment.toJson(),
      where: 'id = ?',
      whereArgs: [appointment.id],
    );
  }

  Future<void> deleteAppointment(int id) async {
    final db = await database;
    await db.delete(
      'appointments',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
