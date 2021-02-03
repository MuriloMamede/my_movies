import 'package:my_movies/app/data/model/movie_model.dart';
import 'package:my_movies/app/data/provider/dataBase_provider.dart';

class MyMoviesProvider {
  final databaseProvider = DataBaseProvider.db;

  Future<List<Movie>> getItens() async {
    final db = await databaseProvider.database;
    var itens = await db.query(DataBaseProvider.MYMOVIES_TABLE, columns: [
      DataBaseProvider.MYMOVIES_TITLE,
      DataBaseProvider.MYMOVIES_POSTERPATH,
      DataBaseProvider.MYMOVIES_ISWATCHED,
      DataBaseProvider.MYMOVIES_ID,
    ]);

    List<Movie> itemList = List<Movie>();

    itens.forEach((currentItem) {
      Movie item = Movie.fromDBMap(currentItem);

      itemList.add(item);
    });

    return itemList;
  }

  Future<Movie> insertItem(Movie item) async {
    final db = await databaseProvider.database;
    item.id = await db.insert(DataBaseProvider.MYMOVIES_TABLE, item.toMap());

    return item;
  }

  Future<int> deleteItem(int id) async {
    final db = await databaseProvider.database;

    return await db.delete(
      DataBaseProvider.MYMOVIES_TABLE,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> updateItem(Movie item) async {
    final db = await databaseProvider.database;

    return await db.update(
      DataBaseProvider.MYMOVIES_TABLE,
      item.toMap(),
      where: "id = ?",
      whereArgs: [item.id],
    );
  }
}

/*import 'package:mvp_vendas/model/carro.dart';
import 'package:mvp_vendas/model/carroItem.dart';
import 'package:mvp_vendas/model/item.dart';
import 'package:mvp_vendas/model/nota.dart';
import 'package:mvp_vendas/model/notaItem.dart';
import 'package:mvp_vendas/model/vendedora.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const String TABLE_ITEM = "item";
  static const String COLUMN_ITEM_ID = "id";
  static const String COLUMN_ITEM_NAME = "name";
  static const String COLUMN_ITEM_VALUE = "value";
  static const String COLUMN_ITEM_QTD = "quantidade";

  static const String TABLE_VENDEDORA = "vendedora";
  static const String COLUMN_VENDEDORA_NOME = "nome_vendedora";
  static const String COLUMN_VENDEDORA_CIDADE = "cidade_vendedora";
  static const String COLUMN_VENDEDORA_CPF = "cpf_vendedora";
  static const String COLUMN_VENDEDORA_TELEFONE = "telefone_vendedora";
  static const String COLUMN_VENDEDORA_CEP = "cep_vendedora";
  static const String COLUMN_VENDEDORA_NUMERO = "numero_vendedora";
  static const String COLUMN_VENDEDORA_EMAIL = "email_vendedora";
  static const String COLUMN_VENDEDORA_RUA = "rua_vendedora";
  static const String COLUMN_VENDEDORA_BAIRRO = "bairro_vendedora";
  static const String COLUMN_VENDEDORA_UF = "uf_vendedora";
  static const String COLUMN_VENDEDORA_ID = "id_vendedora";

  static const String TABLE_NOTA = "nota";
  static const String COLUMN_NOTA_ID = "id";
  static const String COLUMN_NOTA_DATE_CRIADA = "date_criada";
  static const String COLUMN_NOTA_DATE_COBRANCA = "date_cobranca";
  static const String COLUMN_NOTA_ID_VENDEDORA = "id_vendedora";
  static const String COLUMN_NOTA_TOTAL = "total";

  static const String TABLE_NOTAITEM = "nota_item";
  static const String COLUMN_NOTAITEM_ID = "id";
  static const String COLUMN_NOTAITEM_ID_ITEM = "id_item";
  static const String COLUMN_NOTAITEM_ID_NOTA = "id_nota";
  static const String COLUMN_NOTAITEM_QTD = "qtd";

  static const String TABLE_CARRO = "carro";
  static const String COLUMN_CARRO_ID = "id";
  static const String COLUMN_CARRO_PLACA = "placa";

  static const String TABLE_CARROITEM = "carro_item";
  static const String COLUMN_CARROITEM_ID = "id";
  static const String COLUMN_CARROITEM_ID_ITEM = "id_item";
  static const String COLUMN_CARROITEM_ID_CARRO = "id_carro";
  static const String COLUMN_CARROITEM_QTD = "qtd";

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    print("database getter called");

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'dados.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating table item");

        await database.execute("CREATE TABLE $TABLE_ITEM ("
            "$COLUMN_ITEM_ID INTEGER PRIMARY KEY,"
            "$COLUMN_ITEM_NAME TEXT,"
            "$COLUMN_ITEM_VALUE DOUBLE,"
            "$COLUMN_ITEM_QTD INTEGER"
            ")");
        print("creating table vendedora");
        await database.execute(
          "CREATE TABLE $TABLE_VENDEDORA("
          "$COLUMN_VENDEDORA_ID INTEGER PRIMARY KEY,"
          "$COLUMN_VENDEDORA_NOME TEXT,"
          "$COLUMN_VENDEDORA_CPF TEXT,"
          "$COLUMN_VENDEDORA_TELEFONE TEXT,"
          "$COLUMN_VENDEDORA_EMAIL TEXT,"
          "$COLUMN_VENDEDORA_CEP INTEGER,"
          "$COLUMN_VENDEDORA_NUMERO TEXT,"
          "$COLUMN_VENDEDORA_RUA TEXT,"
          "$COLUMN_VENDEDORA_BAIRRO TEXT,"
          "$COLUMN_VENDEDORA_CIDADE TEXT,"
          "$COLUMN_VENDEDORA_UF TEXT"
          ")",
        );

        print("creating table nota");
        await database.execute(
          "CREATE TABLE $TABLE_NOTA("
          "$COLUMN_NOTA_ID INTEGER PRIMARY KEY,"
          "$COLUMN_NOTA_ID_VENDEDORA INTEGER,"
          "$COLUMN_NOTA_DATE_CRIADA TEXT,"
          "$COLUMN_NOTA_DATE_COBRANCA TEXT,"
          "$COLUMN_NOTA_TOTAL REAL,"
          "FOREIGN KEY($COLUMN_NOTA_ID_VENDEDORA) REFERENCES $TABLE_VENDEDORA($COLUMN_VENDEDORA_ID)"
          ")",
        );

        print("creating table notaItem");
        await database.execute(
          "CREATE TABLE $TABLE_NOTAITEM("
          "$COLUMN_NOTAITEM_ID INTEGER PRIMARY KEY,"
          "$COLUMN_NOTAITEM_ID_ITEM INTEGER,"
          "$COLUMN_NOTAITEM_ID_NOTA INTEGER,"
          "$COLUMN_NOTAITEM_QTD INTEGER,"
          "FOREIGN KEY($COLUMN_NOTAITEM_ID_ITEM) REFERENCES $TABLE_ITEM($COLUMN_ITEM_ID),"
          "FOREIGN KEY($COLUMN_NOTAITEM_ID_NOTA) REFERENCES $TABLE_NOTA($COLUMN_NOTA_ID)"
          ")",
        );

        print("creating table carro");
        await database.execute(
          "CREATE TABLE $TABLE_CARRO("
          "$COLUMN_CARRO_ID INTEGER PRIMARY KEY,"
          "$COLUMN_CARRO_PLACA TEXT"
          ")",
        );

        print("creating table carroItem");
        await database.execute(
          "CREATE TABLE $TABLE_CARROITEM("
          "$COLUMN_CARROITEM_ID INTEGER PRIMARY KEY,"
          "$COLUMN_CARROITEM_ID_ITEM INTEGER,"
          "$COLUMN_CARROITEM_QTD INTEGER,"
          "$COLUMN_CARROITEM_ID_CARRO INTEGER,"
          "FOREIGN KEY($COLUMN_CARROITEM_ID_ITEM) REFERENCES $TABLE_ITEM($COLUMN_ITEM_ID),"
          "FOREIGN KEY($COLUMN_CARROITEM_ID_CARRO) REFERENCES $TABLE_CARRO($COLUMN_CARRO_ID)"
          ")",
        );
      },
    );
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("DELETE from vendedora");
  }

/*
***************************************************************
***************************************************************
*********************             ****************************
********************* TABLE ITENS ****************************
*********************              ****************************
***************************************************************
***************************************************************
*/
  Future<List<ItemModel>> getItens() async {
    final db = await database;
    var itens = await db.query(TABLE_ITEM, columns: [
      COLUMN_ITEM_ID,
      COLUMN_ITEM_NAME,
      COLUMN_ITEM_VALUE,
      COLUMN_ITEM_QTD
    ]);

    List<ItemModel> itemList = List<ItemModel>();

    itens.forEach((currentItem) {
      ItemModel item = ItemModel.fromMap(currentItem);

      itemList.add(item);
      print("Item ${item.cod}: ${item.nome}");
    });

    return itemList;
  }

  Future<ItemModel> insertItem(ItemModel item) async {
    final db = await database;
    item.cod = await db.insert(TABLE_ITEM, item.toMap());

    return item;
  }

  Future<int> deleteItem(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_ITEM,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> updateItem(ItemModel item) async {
    final db = await database;

    return await db.update(
      TABLE_ITEM,
      item.toMap(),
      where: "id = ?",
      whereArgs: [item.cod],
    );
  }

  /*
***************************************************************
***************************************************************
*********************             *****************************
********************* TABLE VENDEDORA**************************
*********************              ****************************
***************************************************************
***************************************************************
*/

  Future<List<VendedoraModel>> getVendedoras() async {
    final db = await database;

    var vendedoras = await db.query(TABLE_VENDEDORA, columns: [
      COLUMN_VENDEDORA_TELEFONE,
      COLUMN_VENDEDORA_NOME,
      COLUMN_VENDEDORA_CPF,
      COLUMN_VENDEDORA_EMAIL,
      COLUMN_VENDEDORA_CEP,
      COLUMN_VENDEDORA_RUA,
      COLUMN_VENDEDORA_NUMERO,
      COLUMN_VENDEDORA_BAIRRO,
      COLUMN_VENDEDORA_CIDADE,
      COLUMN_VENDEDORA_UF,
      COLUMN_VENDEDORA_ID
    ]);

    List<VendedoraModel> vendedoraList = List<VendedoraModel>();

    vendedoras.forEach((currentVendedora) {
      VendedoraModel vendedora = VendedoraModel.fromMap(currentVendedora);

      vendedoraList.add(vendedora);
      print("Vendedora: ${vendedora.nome}, id: ${vendedora.id}");
    });

    return vendedoraList;
  }

  Future<VendedoraModel> insertVendedora(VendedoraModel vendedora) async {
    final db = await database;
    vendedora.id = await db.insert(TABLE_VENDEDORA, vendedora.toMap());
    print("Vendedora ${vendedora.nome} de ${vendedora.id} inserida");
    return vendedora;
  }

  Future<int> deleteVendedora(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_VENDEDORA,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> updateVendedora(VendedoraModel vendedora) async {
    final db = await database;

    return await db.update(
      TABLE_VENDEDORA,
      vendedora.toMap(),
      where: "id = ?",
      whereArgs: [vendedora.id],
    );
  }

  /*
***************************************************************
***************************************************************
*********************             *****************************
********************* TABLE NOTA**************************
*********************              ****************************
***************************************************************
***************************************************************
*/
  Future<List<NotaModel>> getNota() async {
    final db = await database;

    var notas = await db.query(TABLE_NOTA, columns: [
      COLUMN_NOTA_ID,
      COLUMN_NOTA_ID_VENDEDORA,
      COLUMN_NOTA_DATE_CRIADA,
      COLUMN_NOTA_DATE_COBRANCA,
      COLUMN_NOTA_TOTAL,
    ]);

    List<NotaModel> notaList = List<NotaModel>();

    notas.forEach((currentNota) {
      NotaModel nota = NotaModel.fromMap(currentNota);

      notaList.add(nota);
      print("Nota: id: ${nota.id}");
    });

    return notaList;
  }

  Future<NotaModel> insertNota(NotaModel nota) async {
    final db = await database;
    nota.id = await db.insert(TABLE_NOTA, nota.toMap());
    print("Nota ${nota.id} inserida");
    return nota;
  }

  Future<int> deleteNota(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_NOTA,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> updateNota(NotaModel nota) async {
    final db = await database;

    return await db.update(
      TABLE_NOTA,
      nota.toMap(),
      where: "id = ?",
      whereArgs: [nota.id],
    );
  }

  /*
***************************************************************
***************************************************************
*********************             *****************************
********************* TABLE NOTAITEM**************************
*********************              ****************************
***************************************************************
***************************************************************
*/
  Future<List<NotaItemModel>> getNotaItem() async {
    final db = await database;

    var notas = await db.query(TABLE_NOTAITEM, columns: [
      COLUMN_NOTAITEM_ID,
      COLUMN_NOTAITEM_ID_ITEM,
      COLUMN_NOTAITEM_ID_NOTA,
      COLUMN_NOTAITEM_QTD,
    ]);

    List<NotaItemModel> notaList = List<NotaItemModel>();

    notas.forEach((currentNotaItem) {
      NotaItemModel notaItem = NotaItemModel.fromMap(currentNotaItem);

      notaList.add(notaItem);
      print("NotaItem: id: ${notaItem.id}");
    });

    return notaList;
  }

  Future<NotaItemModel> insertNotaItem(NotaItemModel notaItem) async {
    final db = await database;
    notaItem.id = await db.insert(TABLE_NOTAITEM, notaItem.toMap());
    print("NotaItem ${notaItem.id} inserida");
    return notaItem;
  }

  Future<int> deleteNotaItem(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_NOTAITEM,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> updateNotaItem(NotaItemModel notaItem) async {
    final db = await database;

    return await db.update(
      TABLE_NOTAITEM,
      notaItem.toMap(),
      where: "id = ?",
      whereArgs: [notaItem.id],
    );
  }
  /*
***************************************************************
***************************************************************
*********************             *****************************
********************* TABLE NOTAITEM**************************
*********************              ****************************
***************************************************************
***************************************************************
*/
  /*Future<List<NotaItemModel>> getCarro() async {
    final db = await database;

    var notas = await db.query(TABLE_NOTAITEM, columns: [
      COLUMN_NOTAITEM_ID,
      COLUMN_NOTAITEM_ID_ITEM,
      COLUMN_NOTAITEM_ID_NOTA,
      COLUMN_NOTAITEM_QTD,
    ]);

    List<NotaItemModel> notaList = List<NotaItemModel>();

    notas.forEach((currentNotaItem) {
      NotaItemModel notaItem = NotaItemModel.fromMap(currentNotaItem);

      notaList.add(notaItem);
      print("NotaItem: id: ${notaItem.id}");
    });

    return notaList;
  }*/

  /* Future<CarroModel> insertCarro(CarroModel carro) async {
    final db = await database;
    carro.id = await db.insert(TABLE_CARRO, carro.toMap());
    print("Carro ${carro.id} inserida");
    return carro;
  }
*/
  /*Future<int> deleteNotaItem(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_NOTAITEM,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> updateNotaItem(NotaItemModel notaItem) async {
    final db = await database;

    return await db.update(
      TABLE_NOTAITEM,
      notaItem.toMap(),
      where: "id = ?",
      whereArgs: [notaItem.id],
    );
  }*/
  /*
***************************************************************
***************************************************************
*********************             *****************************
********************* TABLE NOTAITEM**************************
*********************              ****************************
***************************************************************
***************************************************************
*/ /*
  Future<List<CarroItemModel>> getCarroItem() async {
    final db = await database;

    var carroItens = await db.query(TABLE_CARROITEM, columns: [
      COLUMN_CARROITEM_ID,
      COLUMN_CARROITEM_ID_ITEM,
      COLUMN_CARROITEM_ID_CARRO,
      COLUMN_CARROITEM_QTD,
    ]);

    List<CarroItemModel> carroItemList = List<CarroItemModel>();

    carroItens.forEach((currentCarroItem) {
      CarroItemModel carroItem = CarroItemModel.fromMap(currentCarroItem);

      carroItemList.add(carroItem);
      print("CarroItem: id: ${carroItem.id}");
    });

    return carroItemList;
  }

  Future<CarroItemModel> insertCarroItem(CarroItemModel carroItem) async {
    final db = await database;
    carroItem.id = await db.insert(TABLE_CARROITEM, carroItem.toMap());
    print("CarroItem ${carroItem.id} inserida");
    return carroItem;
  }

  Future<int> deleteCarroItem(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_CARROITEM,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> updatecarroItem(CarroItemModel carroItem) async {
    final db = await database;

    return await db.update(
      TABLE_CARROITEM,
      carroItem.toMap(),
      where: "id = ?",
      whereArgs: [carroItem.id],
    );
  }*/
}
*/
