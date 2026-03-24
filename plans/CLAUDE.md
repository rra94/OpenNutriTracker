# Ayu — Project Plans

> **Ayu** (Sanskrit: आयु — "life / longevity") — fork of OpenNutriTracker into a comprehensive nutrition + longevity tracker.

## Architecture Defaults
```yaml
db: objectbox
architecture: modular (feature-module pattern + service layer)
state: bloc (feature-level, not monolithic)
params: named
platform: flutter_ios
ai: on_device (Core ML / pure Dart)
testing: manual_iphone (after each milestone)
```

## Milestone Index

| Milestone | Directory | Status |
|-----------|-----------|--------|
| [M0: Architecture Refactor](m0-architecture/) | ObjectBox migration, modular structure, service layer | Not started |
| [M1: Nutrient Pipeline](m1-nutrients/) | Micronutrients, RDA, added sugar, Nutritionix, synergy checker | Not started |
| [M2: Home Page UX](m2-home-ux/) | Water, habits, gut health, patterns, 30 plants, Blueprint Mode | Not started |
| [M3: Stats Tab](m3-stats/) | Weight, DEXA, biomarkers, bio age, food-to-feeling, Bristol stool | Not started |
| [M4: Longevity Suite](m4-longevity/) | Supplements, fasting, sleep, meal timing, NSDR timer | Not started |
| [M5: Integrations](m5-integrations/) | HealthKit, HRV correlation, Lock Screen widget | Not started |
| [M6: Intelligence](m6-intelligence/) | Net carbs, GI/GL, omega ratio, weekly review, daily summary | Not started |

## Feature Index (A–Z + competitive edge)

### Core Features
- **A.** Gut health panel → [m2-home-ux/gut-health.md](m2-home-ux/gut-health.md)
- **B.** Micronutrients + RDA → [m1-nutrients/micronutrients.md](m1-nutrients/micronutrients.md)
- **C.** Weight history → [m3-stats/weight.md](m3-stats/weight.md)
- **D.** Stats tab shell → [m3-stats/stats-tab.md](m3-stats/stats-tab.md)
- **E.** Biomarkers → [m3-stats/biomarkers.md](m3-stats/biomarkers.md)
- **F.** Supplements → [m4-longevity/supplements.md](m4-longevity/supplements.md)
- **G.** Fasting timer → [m4-longevity/fasting.md](m4-longevity/fasting.md)
- **H.** Daily habits → [m2-home-ux/habits.md](m2-home-ux/habits.md)
- **I.** Quick-add favorites → [m2-home-ux/favorites.md](m2-home-ux/favorites.md)
- **J.** Water tracking → [m2-home-ux/water.md](m2-home-ux/water.md)
- **K.** Sleep tracking → [m4-longevity/sleep.md](m4-longevity/sleep.md)
- **L.** Meal timing → [m4-longevity/meal-timing.md](m4-longevity/meal-timing.md)
- **M.** Data resolution → [m1-nutrients/data-resolution.md](m1-nutrients/data-resolution.md)
- **N.** Daily summary entity → [m6-intelligence/daily-summary.md](m6-intelligence/daily-summary.md)
- **O.** HealthKit → [m5-integrations/healthkit.md](m5-integrations/healthkit.md)
- **P.** Added sugar → [m1-nutrients/added-sugar.md](m1-nutrients/added-sugar.md)
- **Q.** Cheat meal streak → [m4-longevity/streaks.md](m4-longevity/streaks.md)
- **R.** Pattern auto-logging → [m2-home-ux/patterns.md](m2-home-ux/patterns.md)
- **S.** Nutritionix API → [m1-nutrients/nutritionix.md](m1-nutrients/nutritionix.md)
- **T.** DEXA scan → [m3-stats/dexa.md](m3-stats/dexa.md)
- **U.** Biological age → [m3-stats/bio-age.md](m3-stats/bio-age.md)
- **V.** Longevity insights → [m5-integrations/longevity-insights.md](m5-integrations/longevity-insights.md)
- **W.** Net carbs + GI/GL → [m6-intelligence/glycemic.md](m6-intelligence/glycemic.md)
- **X.** Condensed Home → [m2-home-ux/condensed-layout.md](m2-home-ux/condensed-layout.md)
- **Y.** Weekly review → [m6-intelligence/weekly-review.md](m6-intelligence/weekly-review.md)
- **Z.** Lock Screen widget → [m5-integrations/widget.md](m5-integrations/widget.md)

### Competitive Edge Features (unique to Ayu)
- Nutrient Synergy Checker → [m1-nutrients/synergy-checker.md](m1-nutrients/synergy-checker.md)
- 30 Plants a Week → [m2-home-ux/30-plants.md](m2-home-ux/30-plants.md)
- Blueprint Mode → [m2-home-ux/blueprint-mode.md](m2-home-ux/blueprint-mode.md)
- Food-to-Feeling Engine → [m3-stats/food-to-feeling.md](m3-stats/food-to-feeling.md)
- Bristol Stool Scale → [m3-stats/bristol-stool.md](m3-stats/bristol-stool.md)
- NSDR/Meditation Timer → [m4-longevity/nsdr.md](m4-longevity/nsdr.md)
- HRV-Meal Correlation → [m5-integrations/hrv-correlation.md](m5-integrations/hrv-correlation.md)

## Dependencies
```yaml
objectbox: ^4.0.1
objectbox_flutter_libs: ^4.0.1
fl_chart: ^0.69.0
health: ^11.0.0
home_widget: ^0.7.0
```

## Sources
- [Longevity Coach](https://github.com/longevitycoach)
- [BioAge](https://github.com/dayoonkwon/BioAge)
- [awesome-biomarkers](https://github.com/markwk/awesome-biomarkers)
- [Longevity Supplement Selector](https://github.com/bhoffman1/LongevitySupplementSelector)
