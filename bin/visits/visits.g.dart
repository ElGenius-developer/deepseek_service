// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visits.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Visit _$VisitFromJson(Map<String, dynamic> json) => Visit(
      sheetId: (json['SheetId'] as num?)?.toInt(),
      diagnosisName: (json['DiagnosisName'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      doctorName: json['DoctorName'] as String?,
      specialityName: json['SpecialityName'] as String?,
      netPrice: (json['NetPrice'] as num?)?.toInt(),
      medications: json['Medications'],
      services: (json['Services'] as List<dynamic>?)
          ?.map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList(),
      date:
          json['Date'] == null ? null : DateTime.parse(json['Date'] as String),
      pricePaid: (json['PricePaid'] as num?)?.toInt(),
      priceRemain: (json['PriceRemain'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VisitToJson(Visit instance) => <String, dynamic>{
      'SheetId': instance.sheetId,
      'DiagnosisName': instance.diagnosisName,
      'DoctorName': instance.doctorName,
      'SpecialityName': instance.specialityName,
      'NetPrice': instance.netPrice,
      'Medications': instance.medications,
      'Services': instance.services,
      'Date': instance.date?.toIso8601String(),
      'PricePaid': instance.pricePaid,
      'PriceRemain': instance.priceRemain,
    };

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      name: json['Name'] as String?,
      price: (json['Price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'Name': instance.name,
      'Price': instance.price,
    };
