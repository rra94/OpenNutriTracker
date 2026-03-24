import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:opennutritracker/core/db/entities/intake_ob.dart';
import 'package:opennutritracker/core/db/entities/tracked_day_ob.dart';
import 'package:opennutritracker/core/db/entities/user_ob.dart';
import 'package:opennutritracker/core/db/entities/config_ob.dart';
import 'package:opennutritracker/core/db/entities/user_activity_ob.dart';
import 'package:opennutritracker/core/db/entities/physical_activity_ob.dart';
import 'package:opennutritracker/objectbox.g.dart';

class ObjectBoxDBProvider extends ChangeNotifier {
  late Store store;

  late Box<IntakeOB> intakeBox;
  late Box<TrackedDayOB> trackedDayBox;
  late Box<UserOB> userBox;
  late Box<ConfigOB> configBox;
  late Box<UserActivityOB> userActivityBox;
  late Box<PhysicalActivityOB> physicalActivityBox;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    store = await openStore(directory: '${dir.path}/objectbox');

    intakeBox = store.box<IntakeOB>();
    trackedDayBox = store.box<TrackedDayOB>();
    userBox = store.box<UserOB>();
    configBox = store.box<ConfigOB>();
    userActivityBox = store.box<UserActivityOB>();
    physicalActivityBox = store.box<PhysicalActivityOB>();
  }

  void close() {
    store.close();
  }
}
