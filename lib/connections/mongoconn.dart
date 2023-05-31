import 'package:mongo_dart/mongo_dart.dart' as mongo;

class MongoUtils {
  static late final mongo.Db _db;

  static Future<void> connect() async {
    // Connect to MongoDB Atlas
    _db = await mongo.Db.create('mongodb+srv://shiban:hqwaSJns8vkQVVtk@cluster0.6dhrc7h.mongodb.net/myapp?retryWrites=true&w=majority');
    await _db.open();
  }

  static mongo.Db get db => _db;
}
