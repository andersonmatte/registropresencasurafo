import 'package:registropresencasurafo/entidade/Evento.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseEvento {
  static final databaseName = 'evento.db';
  static final databaseVersion = 1;

  static final table = 'registros';

  static final columnId = 'id';
  static final columnDataInicio = 'dataInicio';
  static final columnDataFim = 'dataFim';
  static final columnDescricao = 'descricao';

  // torna esta classe singleton
  DatabaseEvento._privateConstructor();
  static final DatabaseEvento instance = DatabaseEvento._privateConstructor();

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
        $columnDataInicio TEXT NOT NULL,
        $columnDataFim TEXT NOT NULL,
        $columnDescricao TEXT NOT NULL
      )
      ''');
  }

  Future<int> insereEvento(Evento evento) async {
    Database db = await instance.database;
    return await db.insert(table, evento.toMap());
  }

  Future<List<Evento>> getEventos() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return Evento(
        id: maps[i][columnId],
        dataInicio: maps[i][columnDataInicio],
        dataFim: maps[i][columnDataFim],
        descricao: maps[i][columnDescricao],
      );
    });
  }

}

