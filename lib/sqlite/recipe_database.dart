import 'package:fooderlich/api/recipe_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class RecipeDatabase {
  static const DB_NAME = 'recipe.db';
  static const DB_VERSION = 1;
  static Database? _database;

  RecipeDatabase._internal();

  static final RecipeDatabase instance = RecipeDatabase._internal();

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE TABLE_NAME_RECIPE (
      label INTEGER PRIMARY KEY,
      image TEXT,
      url TEXT,
      ingredients TEXT,
      calories REAL,
      totalWeight REAL,
      totalTime REAL,
    )
    ''');
  }

  Future<Database> _initDB(String fileName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, fileName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future close() async {
    final db = await instance.database;
    db!.close();
  }

  Future<Database?> get database async {
    if(_database != null) {
      return _database;
    } else {
      _database = await _initDB('recipe.db');
      return _database;
    }
  }

  Future<APIRecipe> insertRecipe(APIRecipe recipe) async {
    final db = await instance.database;
    await db!.insert('TABLE_NAME_RECIPE', recipe.toJson());
    return recipe;
  }

  Future<List<APIRecipe>> getAllRecipe() async {
    final db = await instance.database;
    final result = await db!.query(
        'TABLE_NAME_RECIPE'
    );
    return result.map((e) => APIRecipe.fromJson(e)).toList();
  }

  Future<int> deleteRecipe(APIRecipe recipe) async {
    final db = await instance.database;
    return db!.delete(
      'TABLE_NAME_RECIPE',
      where: 'lable = ?',
      whereArgs: [recipe.label, recipe.image, recipe.url, recipe.ingredients, recipe.calories, recipe.totalTime, recipe.totalWeight]
    );
  }

}