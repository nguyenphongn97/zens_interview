import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

enum ResponseType {
  success,
  failure,
}

class DatabaseService {
  DatabaseService._();
  static final DatabaseService instance = DatabaseService._();

  static const String _jokeTableName = "jokes";
  static const String columnId = 'id';
  static const String columnJoke = 'joke';
  static const String columnVote = 'vote';

  static Database? _database;

  Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "masterDB.db");
    return openDatabase(databasePath,
            onCreate: (db, version) async {
      await db.execute("CREATE TABLE $_jokeTableName ("
          "id INTEGER PRIMARY KEY,"
          "joke TEXT,"
          "vote INTEGER"
          ")");

      // Add initial jokes
      await insertInitialJokes(db);
    }, onOpen: (db) {}, version: 1);
  }

  static Future<void> insertInitialJokes(Database db) async {
    final jokes = [
      '''A child asked his father, "How were people born?" So his father said, "Adam and Eve made babies, then their babies became adults and made babies, and so on." The child then went to his mother, asked her the same question and she told him, "We were monkeys then we evolved to become like we are now." The child ran back to his father and said, "You lied to me!" His father replied, "No, your mom was talking about her side of the family."''',
      '''Teacher: "Kids,what does the chicken give you?" Student: "Meat!" Teacher: "Very good! Now what does the pig give you?" Student: "Bacon!" Teacher: "Great! And what does the fat cow give you?" Student: "Homework!"''',
      '''The teacher asked Jimmy, "Why is your cat at school today Jimmy?" Jimmy replied crying, "Because I heard my daddy tell my mommy, 'I am going to eat that pussy once Jimmy leaves for school today!'"''',
      '''A housewife, an accountant and a lawyer were asked "How much is 2+2?" The housewife replies: "Four!". The accountant says: "I think it's either 3 or 4. Let me run those figures through my spreadsheet one more time." The lawyer pulls the drapes, dims the lights and asks in a hushed voice, "How much do you want it to be?"'''
    ];

    for (final joke in jokes) {
      await db.insert(_jokeTableName, {'joke': joke, 'vote': 0},
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<List<Map<String, dynamic>>> getJokes() async {
    final db = await getDatabase();
    return db.rawQuery("SELECT * FROM $_jokeTableName WHERE vote=0");
  }

  Future<ResponseType> updateJokes(int jokeId, int vote) async {
    try{
      final db = await getDatabase();
      final count = await db.update(
        _jokeTableName,
        {
          columnVote: vote,
        },
        where: '$columnId = ?',
        whereArgs: [jokeId],
      );

      if (count > 0) {
        return ResponseType.success;
      } 
      
      return ResponseType.failure;
    }catch(e){

      // Error updating vote for joke with id $jokeId
      return ResponseType.failure;
    }
  }
}
