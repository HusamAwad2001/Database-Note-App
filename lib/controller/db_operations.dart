
abstract class DbOperations<T>{

  ///Create new instance
  ///USES T generic type as specified when class extended
  Future<bool> create(T object);

  ///Read all data from specified instance 'database_table'
  Future<List<T>> read();

  ///Update data for the row holds the PK specified with [id] in [T] 'database_table'
  Future<bool> update(int id, T object);

  ///Delete data for the row holds the PK specified with [id] in [T] 'database_table'
  Future<bool> delete(int id);
}