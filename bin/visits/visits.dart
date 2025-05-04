import 'package:json_annotation/json_annotation.dart';

part 'visits.g.dart';

@JsonSerializable()
class Visit {
  @JsonKey(name: "SheetId")
  final int? sheetId;
  @JsonKey(name: "DiagnosisName")
  final List<String>? diagnosisName;
  @JsonKey(name: "DoctorName")
  final String? doctorName;
  @JsonKey(name: "SpecialityName")
  final String? specialityName;
  @JsonKey(name: "NetPrice")
  final int? netPrice;
  @JsonKey(name: "Medications")
  final dynamic medications;
  @JsonKey(name: "Services")
  final List<Service>? services;
  @JsonKey(name: "Date")
  final DateTime? date;
  @JsonKey(name: "PricePaid")
  final int? pricePaid;
  @JsonKey(name: "PriceRemain")
  final int? priceRemain;

  Visit({
    this.sheetId,
    this.diagnosisName,
    this.doctorName,
    this.specialityName,
    this.netPrice,
    this.medications,
    this.services,
    this.date,
    this.pricePaid,
    this.priceRemain,
  });

  factory Visit.fromJson(Map<String, dynamic> json) => _$VisitFromJson(json);

  Map<String, dynamic> toJson() => _$VisitToJson(this);
}

@JsonSerializable()
class Service {
  @JsonKey(name: "Name")
  final String? name;
  @JsonKey(name: "Price")
  final int? price;

  Service({
    this.name,
    this.price,
  });

  factory Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
