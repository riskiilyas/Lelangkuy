import 'package:lelangkuy/app/data/model/auction.dart';
import 'package:lelangkuy/app/data/model/auction_participation.dart';
import 'package:lelangkuy/app/data/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();

  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'auction_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT,
            password TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE auctions(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId INTEGER,
            title TEXT,
            description TEXT,
            startingPrice REAL
          )
        ''');
        await db.execute('''
          CREATE TABLE auction_participations(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId INTEGER,
            auctionId INTEGER,
            bidAmount TEXT,
            FOREIGN KEY (userId) REFERENCES users(id),
            FOREIGN KEY (auctionId) REFERENCES auctions(id)
          )
        ''');
        await db.execute('''
          CREATE TABLE bookmark_auctions(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId INTEGER,
            saverUserId INTEGER,
            title TEXT,
            description TEXT,
            startingPrice REAL,
            FOREIGN KEY (userId) REFERENCES users(id)
          )
        ''');
      },
    );
  }

  Future<List<Auction>> getAuctionsByUserId(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'auctions',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    return List.generate(maps.length, (i) {
      return Auction.fromJson(maps[i]);
    });
  }

  Future<List<Auction>> getParticipatedAuctions(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT a.*
      FROM auctions a
      INNER JOIN auction_participations ap ON a.id = ap.auctionId
      WHERE ap.userId = ?
    ''', [userId]);

    return List.generate(maps.length, (i) {
      return Auction.fromJson(maps[i]);
    });
  }

  Future<User?> getUserByEmailAndPassword(String email, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (maps.isNotEmpty) {
      return User(
        id: maps.first['id'],
        name: maps.first['name'],
        email: maps.first['email'],
        password: maps.first['password'],
      );
    }
    return null;
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (maps.isNotEmpty) {
      return User(
        id: maps.first['id'],
        name: maps.first['name'],
        email: maps.first['email'],
        password: maps.first['password'],
      );
    }
    return null;
  }

  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert('users', user.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateUser(int id, String name, String email, String password) async {
    final db = await database;
    await db.update(
      'users',
      {'name': name, 'email': email, 'password': password},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete user
  Future<void> deleteUser(int id) async {
    final db = await database;
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertAuction(Auction auction) async {
    final db = await database;
    await db.insert('auctions', auction.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertAuctionParticipation(AuctionParticipation participation) async {
    final db = await database;
    await db.insert('auction_participations', participation.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }


  Future<void> updateAuction(Auction auction) async {
    final db = await database;
    await db.update(
      'auctions',
      auction.toJson(),
      where: 'id = ?',
      whereArgs: [auction.id],
    );
  }

  Future<void> deleteAuction(int auctionId) async {
    final db = await database;
    await db.delete(
      'auctions',
      where: 'id = ?',
      whereArgs: [auctionId],
    );
  }

  Future<List<Auction>> getAllAuctions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('auctions');
    return List.generate(maps.length, (i) {
      return Auction(
        id: maps[i]['id'],
        userId: maps[i]['userId'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        startingPrice: maps[i]['startingPrice'],
      );
    });
  }

  Future<Auction?> getAuctionById(String auctionId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'auctions',
      where: 'id = ?',
      whereArgs: [auctionId],
    );
    if (maps.isNotEmpty) {
      return Auction(
        id: maps.first['id'],
        userId: maps.first['userId'],
        title: maps.first['title'],
        description: maps.first['description'],
        startingPrice: maps.first['startingPrice'],
      );
    }
    return null;
  }

  Future<void> deleteAuctionParticipation(int participationId) async {
    final db = await database;
    await db.delete(
      'auction_participations',
      where: 'id = ?',
      whereArgs: [participationId],
    );
  }

  Future<List<AuctionParticipation>> getParticipationsByUserId(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'auction_participations',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return List.generate(maps.length, (i) {
      return AuctionParticipation(
        id: maps[i]['id'],
        userId: maps[i]['userId'],
        auctionId: maps[i]['auctionId'],
        bidAmount: maps[i]['bidAmount'],
      );
    });
  }

  Future<List<AuctionParticipation>> getParticipationsByAuctionId(String auctionId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'auction_participations',
      where: 'auctionId = ?',
      whereArgs: [auctionId],
    );
    return List.generate(maps.length, (i) {
      return AuctionParticipation(
        id: maps[i]['id'],
        userId: maps[i]['userId'],
        auctionId: maps[i]['auctionId'],
        bidAmount: maps[i]['bidAmount'],
      );
    });
  }

  Future<int> insertBookmarkAuction(Auction auction, int userId) async {
    final db = await database;
    final maps = auction.toJson();
    maps['saverUserId'] = userId;
    return await db.insert('bookmark_auctions', maps);
  }

  // Get all bookmark auctions by userId
  Future<List<Auction>> getBookmarkAuctionsByUserId(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'bookmark_auctions',
      where: 'saverUserId = ?',
      whereArgs: [userId],
    );

    return List.generate(maps.length, (i) {
      return Auction.fromJson(maps[i]);
    });
  }

  // Update a bookmark auction
  Future<int> updateBookmarkAuction(Auction auction) async {
    final db = await database;
    return await db.update(
      'bookmark_auctions',
      auction.toJson(),
      where: 'id = ?',
      whereArgs: [auction.id],
    );
  }

  // Delete a bookmark auction by id
  Future<int> deleteBookmarkAuction(int id) async {
    final db = await database;
    return await db.delete(
      'bookmark_auctions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
