import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'user_data.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      email TEXT NOT NULL,
      nama TEXT NOT NULL,
      password TEXT NOT NULL,
      lahir TEXT,
      gender TEXT,
      phone TEXT,
      pendidikan TEXT,
      pernikahan TEXT,
      nik TEXT,
      alamat TEXT,
      provinsi TEXT,
      kabupaten TEXT,
      kecamatan TEXT,
      kelurahan TEXT,
      kode TEXT,
      is_alamat_sama INTEGER,
      alamat_dom TEXT,
      provinsi_dom TEXT,
      kabupaten_dom TEXT,
      kecamatan_dom TEXT,
      kelurahan_dom TEXT,
      nama_perusahaan TEXT,
      alamat_perusahaan TEXT,
      jabatan TEXT,
      lama_kerja TEXT,
      sumber_pendapatan TEXT,
      total_pendapatan TEXT,
      nama_bank TEXT,
      cabang_bank TEXT,
      rekening TEXT,
      pemilik TEXT
    )
  ''');
  }


  Future<void> insertUser(Map<String,dynamic> data) async {
    final db = await database;
    await db.insert('users', data);
  }

  Future<void> updateUser(int id, Map<String, dynamic> data) async {
    final db = await database;
    await db.update(
      'users',
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }


  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserById(int id) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

}