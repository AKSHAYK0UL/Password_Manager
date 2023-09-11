// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BankAccountModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BankAccountModelAdapter extends TypeAdapter<BankAccountModel> {
  @override
  final int typeId = 1;

  @override
  BankAccountModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BankAccountModel(
      bankName: fields[0] as String,
      branchName: fields[1] as String,
      accountHolderName: fields[2] as String,
      accountNumber: fields[3] as int,
      accountType: fields[4] as String,
      id: fields[8] as String?,
      lastUpdatedDate: fields[9] as DateTime?,
      cardNumber: fields[6] as int?,
      ifcCode: fields[5] as String?,
      atmPin: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, BankAccountModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.bankName)
      ..writeByte(1)
      ..write(obj.branchName)
      ..writeByte(2)
      ..write(obj.accountHolderName)
      ..writeByte(3)
      ..write(obj.accountNumber)
      ..writeByte(4)
      ..write(obj.accountType)
      ..writeByte(5)
      ..write(obj.ifcCode)
      ..writeByte(6)
      ..write(obj.cardNumber)
      ..writeByte(7)
      ..write(obj.atmPin)
      ..writeByte(8)
      ..write(obj.id)
      ..writeByte(9)
      ..write(obj.lastUpdatedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankAccountModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
