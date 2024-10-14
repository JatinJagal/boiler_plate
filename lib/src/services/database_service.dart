import 'package:boiler_plate/src/features/cart/data/cart_data_model.dart';
import 'package:boiler_plate/src/features/cart/data/cart_res_model.dart';
import 'package:boiler_plate/src/utils/app_exception.dart';
import 'package:either_dart/either.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService _i = DatabaseService();

  static DatabaseService get i => _i;

  static double totalPrice = 0.0;

  Future<Database> initializeDatabase() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'shopex.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE cart(id INTEGER PRIMARY KEY ,userid INTEGER , productid INTEGER ,title TEXT NOT NULL, price DOUBLE NOT NULL,image TEXT NOT NULL)");
      },
    );
  }

  Future addProductToCart(CartDataModel cartData) async {
    // final int = 0;
    final Database db = await initializeDatabase();

    final result = await db.insert('cart', cartData.toMap());
    //total
    // totalPrice += cartData.price;
    //
    // print(result);
    return result;
  }

  Future<Either<AppException, List<CartResponsModel>>> getCartData(
      int userId) async {
    //List<CartResponsModel>
    //userId
    /* final Database db = await initializeDatabase();
    // final res = await db.query('cart');
    final res =
        await db.query('cart', where: 'userid = ?', whereArgs: [userId]);
    final data = res.map((e) {
      return CartResponsModel.fromJson(e);
    }).toList();
    print(data);
    return data;
    // return res;*/

    //using try catch
    final Database db = await initializeDatabase();
    // final res = await db.query('cart');
    try {
      final res =
          await db.query('cart', where: 'userid = ?', whereArgs: [userId]);
      final data = res.map((e) {
        return CartResponsModel.fromJson(e);
      }).toList();

      return Right(data);
    } catch (e) {
      return Left(AppException(error: e.toString()));
    }
    // return res;
  }

  Future removeFromCart(CartResponsModel data) async {
    //int id
    final Database db = await initializeDatabase();

    final res = await db.delete('cart', where: "id = ?", whereArgs: [data.id]);
    // totalPrice -= data.price!;
    // if (totalPrice < 0) {
    //   totalPrice == 0.0;
    // }
    print(res);
    return res;
  }

  Future deleteDb() async {
    final Database db = await initializeDatabase();

    try {
      await db.delete('cart');
    } catch (e) {
      print(e);
    }
  }
}
