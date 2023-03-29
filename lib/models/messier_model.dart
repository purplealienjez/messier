import 'package:hive/hive.dart';

part 'messier_model.g.dart';

@HiveType(typeId: 0)
class MessierModel extends HiveObject {
  MessierModel({
    this.id,
    this.messier,
    this.ngc, 
    this.ra,
    this.dec,
    this.sec,
    this.constellation,
    this.magnitude,
    this.description,
    this.observed,
    this.queued,
    this.visible  
  });

  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? messier;

  @HiveField(2)
  final String? ngc;


  @HiveField(3)
  final String? ra;
  
  @HiveField(4)
  final String? dec;
  
  @HiveField(5)
  final String? sec;
  
  @HiveField(6)
  final String? constellation;
  
  @HiveField(7)
  final String? magnitude;
  
  @HiveField(8)
  final String? description;
  
  @HiveField(9)
  bool? observed;
  
  @HiveField(10)
  bool? queued;
  
  @HiveField(11)
  bool? visible;
}