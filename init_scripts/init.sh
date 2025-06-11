#!/bin/bash

set -e

CLICKHOUSE_USER="${CLICKHOUSE_USER}"
CLICKHOUSE_PASSWORD="${CLICKHOUSE_PASSWORD}"
FILE_NAME="${FILE_NAME:-en.openfoodfacts.org.products.csv}"
DATA_DIR="/var/lib/clickhouse/user_files"
FULL_PATH="${DATA_DIR}/${FILE_NAME}"

echo "Creating database..."
clickhouse-client -h localhost \
  --user "${CLICKHOUSE_USER}" \
  --password "${CLICKHOUSE_PASSWORD}" \
  -q "CREATE DATABASE IF NOT EXISTS foodfacts;"


echo "Creating products table..."
clickhouse-client -h localhost \
  --user "${CLICKHOUSE_USER}" \
  --password "${CLICKHOUSE_PASSWORD}" \
  -q "
CREATE TABLE IF NOT EXISTS foodfacts.products (
    \`code\` String,
    \`url\` String,
    \`creator\` String,
    \`created_t\` DateTime,
    \`created_datetime\` DateTime,
    \`last_modified_t\` DateTime,
    \`last_modified_datetime\` DateTime,
    \`last_modified_by\` String,
    \`last_updated_t\` DateTime,
    \`last_updated_datetime\` DateTime,
    \`product_name\` String,
    \`abbreviated_product_name\` String,
    \`generic_name\` String,
    \`quantity\` String,
    \`packaging\` String,
    \`packaging_tags\` String,
    \`packaging_en\` String,
    \`packaging_text\` String,
    \`brands\` String,
    \`brands_tags\` String,
    \`brands_en\` String,
    \`categories\` String,
    \`categories_tags\` String,
    \`categories_en\` String,
    \`origins\` String,
    \`origins_tags\` String,
    \`origins_en\` String,
    \`manufacturing_places\` String,
    \`manufacturing_places_tags\` String,
    \`labels\` String,
    \`labels_tags\` String,
    \`labels_en\` String,
    \`emb_codes\` String,
    \`emb_codes_tags\` String,
    \`first_packaging_code_geo\` String,
    \`cities\` String,
    \`cities_tags\` String,
    \`purchase_places\` String,
    \`stores\` String,
    \`countries\` String,
    \`countries_tags\` String,
    \`countries_en\` String,
    \`ingredients_text\` String,
    \`ingredients_tags\` String,
    \`ingredients_analysis_tags\` String,
    \`allergens\` String,
    \`allergens_en\` String,
    \`traces\` String,
    \`traces_tags\` String,
    \`traces_en\` String,
    \`serving_size\` String,
    \`serving_quantity\` Nullable(Float32),
    \`no_nutrition_data\` String,
    \`additives_n\` Nullable(Int32),
    \`additives\` String,
    \`additives_tags\` String,
    \`_en\` String,
    \`nutriscore_score\` Nullable(Int32),
    \`nutriscore_grade\` String,
    \`nova_group\` Nullable(Int32),
    \`pnns_groups_1\` String,
    \`pnns_groups_2\` String,
    \`food_groups\` String,
    \`food_groups_tags\` String,
    \`food_groups_en\` String,
    \`states\` String,
    \`states_tags\` String,
    \`states_en\` String,
    \`brand_owner\` String,
    \`environmental_score_score\` Nullable(Float32),
    \`environmental_score_grade\` String,
    \`nutrient_levels_tags\` String,
    \`product_quantity\` String,
    \`owner\` String,
    \`data_quality_errors_tags\` String,
    \`unique_scans_n\` Nullable(Int32),
    \`popularity_tags\` String,
    \`completeness\` Nullable(Float32),
    \`last_image_t\` DateTime,
    \`last_image_datetime\` DateTime,
    \`main_category\` String,
    \`main_category_en\` String,
    \`image_url\` String,
    \`image_small_url\` String,
    \`image_ingredients_url\` String,
    \`image_ingredients_small_url\` String,
    \`image_nutrition_url\` String,
    \`image_nutrition_small_url\` String,
    \`energy-kj_100g\` Nullable(Float32),
    \`energy-kcal_100g\` Nullable(Float32),
    \`energy_100g\` Nullable(Float32),
    \`energy-from-fat_100g\` Nullable(Float32),
    \`fat_100g\` Nullable(Float32),
    \`saturated-fat_100g\` Nullable(Float32),
    \`butyric-acid_100g\` Nullable(Float32),
    \`caproic-acid_100g\` Nullable(Float32),
    \`caprylic-acid_100g\` Nullable(Float32),
    \`capric-acid_100g\` Nullable(Float32),
    \`lauric-acid_100g\` Nullable(Float32),
    \`myristic-acid_100g\` Nullable(Float32),
    \`palmitic-acid_100g\` Nullable(Float32),
    \`stearic-acid_100g\` Nullable(Float32),
    \`arachidic-acid_100g\` Nullable(Float32),
    \`behenic-acid_100g\` Nullable(Float32),
    \`lignoceric-acid_100g\` Nullable(Float32),
    \`cerotic-acid_100g\` Nullable(Float32),
    \`montanic-acid_100g\` Nullable(Float32),
    \`melissic-acid_100g\` Nullable(Float32),
    \`unsaturated-fat_100g\` Nullable(Float32),
    \`monounsaturated-fat_100g\` Nullable(Float32),
    \`omega-9-fat_100g\` Nullable(Float32),
    \`polyunsaturated-fat_100g\` Nullable(Float32),
    \`omega-3-fat_100g\` Nullable(Float32),
    \`omega-6-fat_100g\` Nullable(Float32),
    \`alpha-linolenic-acid_100g\` Nullable(Float32),
    \`eicosapentaenoic-acid_100g\` Nullable(Float32),
    \`docosahexaenoic-acid_100g\` Nullable(Float32),
    \`linoleic-acid_100g\` Nullable(Float32),
    \`arachidonic-acid_100g\` Nullable(Float32),
    \`gamma-linolenic-acid_100g\` Nullable(Float32),
    \`dihomo-gamma-linolenic-acid_100g\` Nullable(Float32),
    \`oleic-acid_100g\` Nullable(Float32),
    \`elaidic-acid_100g\` Nullable(Float32),
    \`gondoic-acid_100g\` Nullable(Float32),
    \`mead-acid_100g\` Nullable(Float32),
    \`erucic-acid_100g\` Nullable(Float32),
    \`nervonic-acid_100g\` Nullable(Float32),
    \`trans-fat_100g\` Nullable(Float32),
    \`cholesterol_100g\` Nullable(Float32),
    \`carbohydrates_100g\` Nullable(Float32),
    \`sugars_100g\` Nullable(Float32),
    \`added-sugars_100g\` Nullable(Float),
    \`sucrose_100g\` Nullable(Float32),
    \`glucose_100g\` Nullable(Float32),
    \`fructose_100g\` Nullable(Float32),
    \`galactose_100g\` Nullable(Float32),
    \`lactose_100g\` Nullable(Float32),
    \`maltose_100g\` Nullable(Float32),
    \`maltodextrins_100g\` Nullable(Float32),
    \`starch_100g\` Nullable(Float32),
    \`polyols_100g\` Nullable(Float32),
    \`erythritol_100g\` Nullable(Float32),
    \`fiber_100g\` Nullable(Float32),
    \`soluble-fiber_100g\` Nullable(Float32),
    \`insoluble-fiber_100g\` Nullable(Float32),
    \`proteins_100g\` Nullable(Float32),
    \`casein_100g\` Nullable(Float32),
    \`serum-proteins_100g\` Nullable(Float32),
    \`nucleotides_100g\` Nullable(Float32),
    \`salt_100g\` Nullable(Float32),
    \`added-salt_100g\` Nullable(Float32),
    \`sodium_100g\` Nullable(Float32),
    \`alcohol_100g\` Nullable(Float32),
    \`vitamin-a_100g\` Nullable(Float32),
    \`beta-carotene_100g\` Nullable(Float32),
    \`vitamin-d_100g\` Nullable(Float32),
    \`vitamin-e_100g\` Nullable(Float32),
    \`vitamin-k_100g\` Nullable(Float32),
    \`vitamin-c_100g\` Nullable(Float32),
    \`vitamin-b1_100g\` Nullable(Float32),
    \`vitamin-b2_100g\` Nullable(Float32),
    \`vitamin-pp_100g\` Nullable(Float32),
    \`vitamin-b6_100g\` Nullable(Float32),
    \`vitamin-b9_100g\` Nullable(Float32),
    \`folates_100g\` Nullable(Float32),
    \`vitamin-b12_100g\` Nullable(Float32),
    \`biotin_100g\` Nullable(Float32),
    \`pantothenic-acid_100g\` Nullable(Float32),
    \`silica_100g\` Nullable(Float32),
    \`bicarbonate_100g\` Nullable(Float32),
    \`potassium_100g\` Nullable(Float32),
    \`chloride_100g\` Nullable(Float32),
    \`calcium_100g\` Nullable(Float32),
    \`phosphorus_100g\` Nullable(Float32),
    \`iron_100g\` Nullable(Float32),
    \`magnesium_100g\` Nullable(Float32),
    \`zinc_100g\` Nullable(Float32),
    \`copper_100g\` Nullable(Float32),
    \`manganese_100g\` Nullable(Float32),
    \`fluoride_100g\` Nullable(Float32),
    \`selenium_100g\` Nullable(Float32),
    \`chromium_100g\` Nullable(Float32),
    \`molybdenum_100g\` Nullable(Float32),
    \`iodine_100g\` Nullable(Float32),
    \`caffeine_100g\` Nullable(Float32),
    \`taurine_100g\` Nullable(Float32),
    \`ph_100g\` Nullable(Float32),
    \`fruits-vegetables-nuts_100g\` Nullable(Float32),
    \`fruits-vegetables-nuts-dried_100g\` Nullable(Float32),
    \`fruits-vegetables-nuts-estimate_100g\` Nullable(Float32),
    \`fruits-vegetables-nuts-estimate-from-ingredients_100g\` Nullable(Float32),
    \`collagen-meat-protein-ratio_100g\` Nullable(Float32),
    \`cocoa_100g\` Nullable(Float32),
    \`chlorophyl_100g\` Nullable(Float32),
    \`carbon-footprint_100g\` Nullable(Float32),
    \`carbon-footprint-from-meat-or-fish_100g\` Nullable(Float32),
    \`nutrition-score-fr_100g\` Nullable(Float32),
    \`nutrition-score-uk_100g\` Nullable(Float32),
    \`glycemic-index_100g\` Nullable(Float32),
    \`water-hardness_100g\` Nullable(Float32),
    \`choline_100g\` Nullable(Float32),
    \`phylloquinone_100g\` Nullable(Float32),
    \`beta-glucan_100g\` Nullable(Float32),
    \`inositol_100g\` Nullable(Float32),
    \`carnitine_100g\` Nullable(Float32),
    \`sulphate_100g\` Nullable(Float32),
    \`nitrate_100g\` Nullable(Float32),
    \`acidity_100g\` Nullable(Float32),
    \`carbohydrates-total_100g\` Nullable(Float32)
) ENGINE = MergeTree()
ORDER BY (code);
"

echo "Importing data from ${FILE_NAME}..."
clickhouse-client -h localhost \
  --user "${CLICKHOUSE_USER}" \
  --password "${CLICKHOUSE_PASSWORD}" \
  -q "
INSERT INTO foodfacts.products
SELECT *
FROM file(
    '${FULL_PATH}', 
    'TSVWithNames'
)
SETTINGS 
    input_format_null_as_default = 1,
    format_csv_delimiter = '\t',
    date_time_input_format = 'best_effort',
    input_format_allow_errors_num = 100000,
    input_format_allow_errors_ratio = 0.4;
"

echo "Creating predicts table..."
clickhouse-client -h localhost \
  --user "${CLICKHOUSE_USER}" \
  --password "${CLICKHOUSE_PASSWORD}" \
  --multiquery \
  -q "
CREATE TABLE IF NOT EXISTS foodfacts.predicts AS foodfacts.products
ENGINE = MergeTree()
ORDER BY (code);
"

echo "Adding prediction column..."
clickhouse-client -h localhost \
  --user "${CLICKHOUSE_USER}" \
  --password "${CLICKHOUSE_PASSWORD}" \
  -q "
ALTER TABLE foodfacts.predicts
ADD COLUMN IF NOT EXISTS \`prediction\` Nullable(Float32) AFTER  \`carbohydrates-total_100g\`;
"

echo "Initialization completed!"
