import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';
import 'package:opennutritracker/core/data/dbo/config_dbo.dart';
import 'package:opennutritracker/core/data/dbo/intake_dbo.dart';
import 'package:opennutritracker/core/data/dbo/tracked_day_dbo.dart';
import 'package:opennutritracker/core/data/dbo/user_dbo.dart';
import 'package:opennutritracker/core/data/data_source/user_activity_dbo.dart';
import 'package:opennutritracker/core/db/data_sources/config_data_source_ob.dart';
import 'package:opennutritracker/core/db/data_sources/intake_data_source_ob.dart';
import 'package:opennutritracker/core/db/data_sources/tracked_day_data_source_ob.dart';
import 'package:opennutritracker/core/db/data_sources/user_activity_data_source_ob.dart';
import 'package:opennutritracker/core/db/data_sources/user_data_source_ob.dart';
import 'package:opennutritracker/core/db/objectbox_db_provider.dart';
import 'package:opennutritracker/core/utils/hive_db_provider.dart';

class HiveToObjectBoxMigration {
  static final _log = Logger('HiveToObjectBoxMigration');

  static Future<bool> needsMigration(ObjectBoxDBProvider obProvider) async {
    final configBox = obProvider.configBox;
    final configs = configBox.getAll();
    if (configs.isEmpty) return true;
    return !configs.first.hiveMigrationComplete;
  }

  static Future<void> migrate({
    required HiveDBProvider hiveProvider,
    required ObjectBoxDBProvider obProvider,
  }) async {
    _log.info('Starting Hive → ObjectBox migration...');

    // Migrate config
    await _migrateConfig(hiveProvider, obProvider);

    // Migrate user
    await _migrateUser(hiveProvider, obProvider);

    // Migrate intakes
    await _migrateIntakes(hiveProvider, obProvider);

    // Migrate tracked days
    await _migrateTrackedDays(hiveProvider, obProvider);

    // Migrate user activities
    await _migrateUserActivities(hiveProvider, obProvider);

    // Mark migration complete directly on ObjectBox entity
    final configs = obProvider.configBox.getAll();
    if (configs.isNotEmpty) {
      configs.first.hiveMigrationComplete = true;
      obProvider.configBox.put(configs.first);
    }

    _log.info('Hive → ObjectBox migration complete.');
  }

  static Future<void> _migrateConfig(
      HiveDBProvider hive, ObjectBoxDBProvider ob) async {
    try {
      final hiveConfigs = hive.configBox.values.toList();
      if (hiveConfigs.isEmpty) return;

      final configDs = ConfigDataSourceOB(ob.configBox);
      if (await configDs.configInitialized()) return;

      final hiveConfig = hiveConfigs.first;
      await configDs.addConfig(hiveConfig);
      _log.info('Migrated config');
    } catch (e) {
      _log.warning('Config migration failed: $e');
    }
  }

  static Future<void> _migrateUser(
      HiveDBProvider hive, ObjectBoxDBProvider ob) async {
    try {
      final hiveUsers = hive.userBox.values.toList();
      if (hiveUsers.isEmpty) return;

      final userDs = UserDataSourceOB(ob.userBox);
      if (await userDs.hasUserData()) return;

      await userDs.saveUserData(hiveUsers.first);
      _log.info('Migrated user');
    } catch (e) {
      _log.warning('User migration failed: $e');
    }
  }

  static Future<void> _migrateIntakes(
      HiveDBProvider hive, ObjectBoxDBProvider ob) async {
    try {
      final hiveIntakes = hive.intakeBox.values.toList();
      if (hiveIntakes.isEmpty) return;

      final intakeDs = IntakeDataSourceOB(ob.intakeBox);
      final existingIntakes = await intakeDs.getAllIntakes();
      if (existingIntakes.isNotEmpty) return;

      await intakeDs.addAllIntakes(hiveIntakes);
      _log.info('Migrated ${hiveIntakes.length} intakes');
    } catch (e) {
      _log.warning('Intake migration failed: $e');
    }
  }

  static Future<void> _migrateTrackedDays(
      HiveDBProvider hive, ObjectBoxDBProvider ob) async {
    try {
      final hiveDays = hive.trackedDayBox.values.toList();
      if (hiveDays.isEmpty) return;

      final dayDs = TrackedDayDataSourceOB(ob.trackedDayBox);
      final existingDays = await dayDs.getAllTrackedDays();
      if (existingDays.isNotEmpty) return;

      await dayDs.saveAllTrackedDays(hiveDays);
      _log.info('Migrated ${hiveDays.length} tracked days');
    } catch (e) {
      _log.warning('Tracked day migration failed: $e');
    }
  }

  static Future<void> _migrateUserActivities(
      HiveDBProvider hive, ObjectBoxDBProvider ob) async {
    try {
      final hiveActivities = hive.userActivityBox.values.toList();
      if (hiveActivities.isEmpty) return;

      final activityDs = UserActivityDataSourceOB(ob.userActivityBox);
      final existingActivities = await activityDs.getAllUserActivities();
      if (existingActivities.isNotEmpty) return;

      await activityDs.addAllUserActivities(hiveActivities);
      _log.info('Migrated ${hiveActivities.length} user activities');
    } catch (e) {
      _log.warning('User activity migration failed: $e');
    }
  }
}
