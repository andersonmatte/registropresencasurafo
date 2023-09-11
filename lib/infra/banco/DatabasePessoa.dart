import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../entidade/Pessoa.dart';

class DatabasePessoa {
  static final databaseName = 'pessoa.db';
  static final databaseVersion = 1;

  static final table = 'pessoas';

  static final columnId = 'id';
  static final columnIdEvento = 'idEvento';
  static final columnNome = 'nome';
  static final columnTelefone = 'telefone';

  // torna esta classe singleton
  DatabasePessoa._privateConstructor();

  static final DatabasePessoa instance = DatabasePessoa._privateConstructor();

  static Database? banco;

  Future<Database> get database async {
    if (banco != null) return banco!;
    // instancia o banco de dados se ele ainda não existir
    banco = await initDatabase();
    return banco!;
  }

  // inicializa o banco de dados
  initDatabase() async {
    String path = join(await getDatabasesPath(), databaseName);
    return await openDatabase(path,
        version: databaseVersion, onCreate: onCreate);
  }

  Future onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnIdEvento TEXT NOT NULL,
        $columnNome TEXT NOT NULL,
        $columnTelefone TEXT NOT NULL
      )
      ''');
  }

  Future<int> inserePessoa(Pessoa pessoa) async {
    Database db = await instance.database;
    return await db.insert(table, pessoa.toMap());
  }

  Future<List<Pessoa>> getPessoasPorIdEvento(int idEvento) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      table,
      where: '$columnIdEvento = ?',
      whereArgs: [idEvento],
    );
    return List.generate(maps.length, (i) {
      return Pessoa(
        id: maps[i][columnId],
        idEvento: int.parse(maps[i][columnIdEvento].toString()), // Conversão para int
        nome: maps[i][columnNome],
        telefone: maps[i][columnTelefone],
      );
    });
  }
}
