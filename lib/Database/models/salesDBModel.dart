final String tableName = 'TireSalesDBFinal';

class SalesDBFields {
  static final List<String> values = [
    id,
    customerName,
    description,
    total,
    dateTime,
    dateTimeTDT
  ];

  static final String id = 'id';
  static final String customerName = 'CustomerName';
  static final String description = 'description';
  static final String total = 'total';
  static final String dateTime = 'TransactionDate';
  static final String dateTimeTDT = 'DateInserted';
}

class SalesDBModel {
  final int? id;
  final String? customerName;
  final String? description;
  final double? total;
  final DateTime? dateTime;
  final DateTime? dateTimeTDT;

  const SalesDBModel(
      {this.id,
      required this.customerName,
      required this.description,
      required this.total,
      required this.dateTime,
      required this.dateTimeTDT});
  SalesDBModel copy(
          {int? id,
          String? customerName,
          String? description,
          double? total,
          DateTime? dateTime,
          DateTime? dateTimeTDT}) =>
      SalesDBModel(
        id: id ?? this.id,
        customerName: customerName ?? this.customerName,
        description: description ?? this.description,
        total: total ?? this.total,
        dateTime: dateTime ?? this.dateTime,
        dateTimeTDT: dateTimeTDT ?? this.dateTimeTDT,
      );

  static SalesDBModel fromJson(Map<String, Object?> json) => SalesDBModel(
        id: json[SalesDBFields.id] as int?,
        customerName: json[SalesDBFields.customerName] as String,
        description: json[SalesDBFields.description] as String,
        total: double.parse(json[SalesDBFields.total] as String),
        dateTime: DateTime.parse(
          json[SalesDBFields.dateTime] as String,
        ),
        dateTimeTDT: DateTime.parse(
          json[SalesDBFields.dateTimeTDT] as String,
        ),
      );

  Map<String, Object?> toJson() => {
        SalesDBFields.customerName: customerName,
        SalesDBFields.description: description,
        SalesDBFields.total: total,
        SalesDBFields.dateTime: dateTime!.toIso8601String(),
        SalesDBFields.dateTimeTDT: dateTimeTDT!.toIso8601String(),
      };
}
