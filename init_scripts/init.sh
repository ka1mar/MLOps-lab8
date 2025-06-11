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


echo "Creating new products table with explicit schema..."
clickhouse-client -h localhost \
 --user "${CLICKHOUSE_USER}" \
 --password "${CLICKHOUSE_PASSWORD}" \
 -q "
CREATE TABLE IF NOT EXISTS foodfacts.products (
   \`code\` String,
   \`url\` String,
   \`creator\` String,
   \`last_modified_by\` String,
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
   \`serving_quantity\` Nullable(Float64),
   \`no_nutrition_data\` String,
   \`additives_n\` Nullable(Int32),
   \`additives\` String,
   \`additives_tags\` String,
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
   \`environmental_score_score\` Nullable(Float64),
   \`environmental_score_grade\` String,
   \`nutrient_levels_tags\` String,
   \`product_quantity\` String,
   \`owner\` String,
   \`data_quality_errors_tags\` String,
   \`unique_scans_n\` Nullable(Int32),
   \`popularity_tags\` String,
   \`completeness\` Nullable(Float64),
   \`main_category\` String,
   \`main_category_en\` String,
   \`image_url\` String,
   \`image_small_url\` String,
   \`image_ingredients_url\` String,
   \`image_ingredients_small_url\` String,
   \`image_nutrition_url\` String,
   \`image_nutrition_small_url\` String,
   \`energy-kj_100g\` Nullable(Float64),
   \`energy-kcal_100g\` Nullable(Float64),
   \`energy_100g\` Nullable(Float64),
   \`energy-from-fat_100g\` Nullable(Float64),
   \`fat_100g\` Nullable(Float64),
   \`saturated-fat_100g\` Nullable(Float64),
   \`butyric-acid_100g\` Nullable(Float64),
   \`caproic-acid_100g\` Nullable(Float64),
   \`caprylic-acid_100g\` Nullable(Float64),
   \`capric-acid_100g\` Nullable(Float64),
   \`lauric-acid_100g\` Nullable(Float64),
   \`myristic-acid_100g\` Nullable(Float64),
   \`palmitic-acid_100g\` Nullable(Float64),
   \`stearic-acid_100g\` Nullable(Float64),
   \`arachidic-acid_100g\` Nullable(Float64),
   \`behenic-acid_100g\` Nullable(Float64),
   \`lignoceric-acid_100g\` Nullable(Float64),
   \`cerotic-acid_100g\` Nullable(Float64),
   \`montanic-acid_100g\` Nullable(Float64),
   \`melissic-acid_100g\` Nullable(Float64),
   \`unsaturated-fat_100g\` Nullable(Float64),
   \`monounsaturated-fat_100g\` Nullable(Float64),
   \`omega-9-fat_100g\` Nullable(Float64),
   \`polyunsaturated-fat_100g\` Nullable(Float64),
   \`omega-3-fat_100g\` Nullable(Float64),
   \`omega-6-fat_100g\` Nullable(Float64),
   \`alpha-linolenic-acid_100g\` Nullable(Float64),
   \`eicosapentaenoic-acid_100g\` Nullable(Float64),
   \`docosahexaenoic-acid_100g\` Nullable(Float64),
   \`linoleic-acid_100g\` Nullable(Float64),
   \`arachidonic-acid_100g\` Nullable(Float64),
   \`gamma-linolenic-acid_100g\` Nullable(Float64),
   \`dihomo-gamma-linolenic-acid_100g\` Nullable(Float64),
   \`oleic-acid_100g\` Nullable(Float64),
   \`elaidic-acid_100g\` Nullable(Float64),
   \`gondoic-acid_100g\` Nullable(Float64),
   \`mead-acid_100g\` Nullable(Float64),
   \`erucic-acid_100g\` Nullable(Float64),
   \`nervonic-acid_100g\` Nullable(Float64),
   \`trans-fat_100g\` Nullable(Float64),
   \`cholesterol_100g\` Nullable(Float64),
   \`carbohydrates_100g\` Nullable(Float64),
   \`sugars_100g\` Nullable(Float64),
   \`added-sugars_100g\` Nullable(Float64),
   \`sucrose_100g\` Nullable(Float64),
   \`glucose_100g\` Nullable(Float64),
   \`fructose_100g\` Nullable(Float64),
   \`galactose_100g\` Nullable(Float64),
   \`lactose_100g\` Nullable(Float64),
   \`maltose_100g\` Nullable(Float64),
   \`maltodextrins_100g\` Nullable(Float64),
   \`starch_100g\` Nullable(Float64),
   \`polyols_100g\` Nullable(Float64),
   \`erythritol_100g\` Nullable(Float64),
   \`fiber_100g\` Nullable(Float64),
   \`soluble-fiber_100g\` Nullable(Float64),
   \`insoluble-fiber_100g\` Nullable(Float64),
   \`proteins_100g\` Nullable(Float64),
   \`casein_100g\` Nullable(Float64),
   \`serum-proteins_100g\` Nullable(Float64),
   \`nucleotides_100g\` Nullable(Float64),
   \`salt_100g\` Nullable(Float64),
   \`added-salt_100g\` Nullable(Float64),
   \`sodium_100g\` Nullable(Float64),
   \`alcohol_100g\` Nullable(Float64),
   \`vitamin-a_100g\` Nullable(Float64),
   \`beta-carotene_100g\` Nullable(Float64),
   \`vitamin-d_100g\` Nullable(Float64),
   \`vitamin-e_100g\` Nullable(Float64),
   \`vitamin-k_100g\` Nullable(Float64),
   \`vitamin-c_100g\` Nullable(Float64),
   \`vitamin-b1_100g\` Nullable(Float64),
   \`vitamin-b2_100g\` Nullable(Float64),
   \`vitamin-pp_100g\` Nullable(Float64),
   \`vitamin-b6_100g\` Nullable(Float64),
   \`vitamin-b9_100g\` Nullable(Float64),
   \`folates_100g\` Nullable(Float64),
   \`vitamin-b12_100g\` Nullable(Float64),
   \`biotin_100g\` Nullable(Float64),
   \`pantothenic-acid_100g\` Nullable(Float64),
   \`silica_100g\` Nullable(Float64),
   \`bicarbonate_100g\` Nullable(Float64),
   \`potassium_100g\` Nullable(Float64),
   \`chloride_100g\` Nullable(Float64),
   \`calcium_100g\` Nullable(Float64),
   \`phosphorus_100g\` Nullable(Float64),
   \`iron_100g\` Nullable(Float64),
   \`magnesium_100g\` Nullable(Float64),
   \`zinc_100g\` Nullable(Float64),
   \`copper_100g\` Nullable(Float64),
   \`manganese_100g\` Nullable(Float64),
   \`fluoride_100g\` Nullable(Float64),
   \`selenium_100g\` Nullable(Float64),
   \`chromium_100g\` Nullable(Float64),
   \`molybdenum_100g\` Nullable(Float64),
   \`iodine_100g\` Nullable(Float64),
   \`caffeine_100g\` Nullable(Float64),
   \`taurine_100g\` Nullable(Float64),
   \`ph_100g\` Nullable(Float64),
   \`fruits-vegetables-nuts_100g\` Nullable(Float64),
   \`fruits-vegetables-nuts-dried_100g\` Nullable(Float64),
   \`fruits-vegetables-nuts-estimate_100g\` Nullable(Float64),
   \`fruits-vegetables-nuts-estimate-from-ingredients_100g\` Nullable(Float64),
   \`collagen-meat-protein-ratio_100g\` Nullable(Float64),
   \`cocoa_100g\` Nullable(Float64),
   \`chlorophyl_100g\` Nullable(Float64),
   \`carbon-footprint_100g\` Nullable(Float64),
   \`carbon-footprint-from-meat-or-fish_100g\` Nullable(Float64),
   \`nutrition-score-fr_100g\` Nullable(Float64),
   \`nutrition-score-uk_100g\` Nullable(Float64),
   \`glycemic-index_100g\` Nullable(Float64),
   \`water-hardness_100g\` Nullable(Float64),
   \`choline_100g\` Nullable(Float64),
   \`phylloquinone_100g\` Nullable(Float64),
   \`beta-glucan_100g\` Nullable(Float64),
   \`inositol_100g\` Nullable(Float64),
   \`carnitine_100g\` Nullable(Float64),
   \`sulphate_100g\` Nullable(Float64),
   \`nitrate_100g\` Nullable(Float64),
   \`acidity_100g\` Nullable(Float64),
   \`carbohydrates-total_100g\` Nullable(Float64)
) ENGINE = MergeTree()
ORDER BY (code);
"


  echo "Importing data with explicit casting..."
  clickhouse-client -h localhost \
  --user "${CLICKHOUSE_USER}" \
  --password "${CLICKHOUSE_PASSWORD}" \
  -q "
INSERT INTO foodfacts.products
SELECT
  toValidUTF8(\`code\`) as code,
  toValidUTF8(url) as url,
  toValidUTF8(creator) as creator,
  toValidUTF8(last_modified_by) as last_modified_by,
  toValidUTF8(product_name) as product_name,
  toValidUTF8(abbreviated_product_name) as abbreviated_product_name,
  toValidUTF8(generic_name) as generic_name,
  toValidUTF8(quantity) as quantity,
  toValidUTF8(packaging) as packaging,
  toValidUTF8(packaging_tags) as packaging_tags,
  toValidUTF8(packaging_en) as packaging_en,
  toValidUTF8(packaging_text) as packaging_text,
  toValidUTF8(brands) as brands,
  toValidUTF8(brands_tags) as brands_tags,
  toValidUTF8(brands_en) as brands_en,
  toValidUTF8(categories) as categories,
  toValidUTF8(categories_tags) as categories_tags,
  toValidUTF8(categories_en) as categories_en,
  toValidUTF8(origins) as origins,
  toValidUTF8(origins_tags) as origins_tags,
  toValidUTF8(origins_en) as origins_en,
  toValidUTF8(manufacturing_places) as manufacturing_places,
  toValidUTF8(manufacturing_places_tags) as manufacturing_places_tags,
  toValidUTF8(labels) as labels,
  toValidUTF8(labels_tags) as labels_tags,
  toValidUTF8(labels_en) as labels_en,
  toValidUTF8(emb_codes) as emb_codes,
  toValidUTF8(emb_codes_tags) as emb_codes_tags,
  toValidUTF8(first_packaging_code_geo) as first_packaging_code_geo,
  toValidUTF8(cities) as cities,
  toValidUTF8(cities_tags) as cities_tags,
  toValidUTF8(purchase_places) as purchase_places,
  toValidUTF8(stores) as stores,
  toValidUTF8(countries) as countries,
  toValidUTF8(countries_tags) as countries_tags,
  toValidUTF8(countries_en) as countries_en,
  toValidUTF8(ingredients_text) as ingredients_text,
  toValidUTF8(ingredients_tags) as ingredients_tags,
  toValidUTF8(ingredients_analysis_tags) as ingredients_analysis_tags,
  toValidUTF8(allergens) as allergens,
  toValidUTF8(allergens_en) as allergens_en,
  toValidUTF8(traces) as traces,
  toValidUTF8(traces_tags) as traces_tags,
  toValidUTF8(traces_en) as traces_en,
  toValidUTF8(serving_size) as serving_size,
  toFloat64OrNull(toString(serving_quantity)),
  toValidUTF8(no_nutrition_data) as no_nutrition_data,
  toInt32OrNull(toString(additives_n)),
  toValidUTF8(additives) as additives,
  toValidUTF8(additives_tags) as additives_tags,
  toInt32OrNull(toString(nutriscore_score)),
  toValidUTF8(nutriscore_grade) as nutriscore_grade,
  toInt32OrNull(toString(nova_group)),
  toValidUTF8(pnns_groups_1) as pnns_groups_1,
  toValidUTF8(pnns_groups_2) as pnns_groups_2,
  toValidUTF8(food_groups) as food_groups,
  toValidUTF8(food_groups_tags) as food_groups_tags,
  toValidUTF8(food_groups_en) as food_groups_en,
  toValidUTF8(states) as states,
  toValidUTF8(states_tags) as states_tags,
  toValidUTF8(states_en) as states_en,
  toValidUTF8(brand_owner) as brand_owner,
  toFloat64OrNull(toString(environmental_score_score)),
  toValidUTF8(environmental_score_grade) as environmental_score_grade,
  toValidUTF8(nutrient_levels_tags) as nutrient_levels_tags,
  toValidUTF8(product_quantity) as product_quantity,
  toValidUTF8(owner) as owner,
  toValidUTF8(data_quality_errors_tags) as data_quality_errors_tags,
  toInt32OrNull(toString(unique_scans_n)),
  toValidUTF8(popularity_tags) as popularity_tags,
  toFloat64OrNull(toString(completeness)),
  toValidUTF8(main_category) as main_category,
  toValidUTF8(main_category_en) as main_category_en,
  toValidUTF8(image_url) as image_url,
  toValidUTF8(image_small_url) as image_small_url,
  toValidUTF8(image_ingredients_url) as image_ingredients_url,
  toValidUTF8(image_ingredients_small_url) as image_ingredients_small_url,
  toValidUTF8(image_nutrition_url) as image_nutrition_url,
  toValidUTF8(image_nutrition_small_url) as image_nutrition_small_url,
  toFloat64OrNull(toString(\`energy-kj_100g\`)),
  toFloat64OrNull(toString(\`energy-kcal_100g\`)),
  toFloat64OrNull(toString(energy_100g)),
  toFloat64OrNull(toString(\`energy-from-fat_100g\`)),
  toFloat64OrNull(toString(fat_100g)),
  toFloat64OrNull(toString(\`saturated-fat_100g\`)),
  toFloat64OrNull(toString(\`butyric-acid_100g\`)),
  toFloat64OrNull(toString(\`caproic-acid_100g\`)),
  toFloat64OrNull(toString(\`caprylic-acid_100g\`)),
  toFloat64OrNull(toString(\`capric-acid_100g\`)),
  toFloat64OrNull(toString(\`lauric-acid_100g\`)),
  toFloat64OrNull(toString(\`myristic-acid_100g\`)),
  toFloat64OrNull(toString(\`palmitic-acid_100g\`)),
  toFloat64OrNull(toString(\`stearic-acid_100g\`)),
  toFloat64OrNull(toString(\`arachidic-acid_100g\`)),
  toFloat64OrNull(toString(\`behenic-acid_100g\`)),
  toFloat64OrNull(toString(\`lignoceric-acid_100g\`)),
  toFloat64OrNull(toString(\`cerotic-acid_100g\`)),
  toFloat64OrNull(toString(\`montanic-acid_100g\`)),
  toFloat64OrNull(toString(\`melissic-acid_100g\`)),
  toFloat64OrNull(toString(\`unsaturated-fat_100g\`)),
  toFloat64OrNull(toString(\`monounsaturated-fat_100g\`)),
  toFloat64OrNull(toString(\`omega-9-fat_100g\`)),
  toFloat64OrNull(toString(\`polyunsaturated-fat_100g\`)),
  toFloat64OrNull(toString(\`omega-3-fat_100g\`)),
  toFloat64OrNull(toString(\`omega-6-fat_100g\`)),
  toFloat64OrNull(toString(\`alpha-linolenic-acid_100g\`)),
  toFloat64OrNull(toString(\`eicosapentaenoic-acid_100g\`)),
  toFloat64OrNull(toString(\`docosahexaenoic-acid_100g\`)),
  toFloat64OrNull(toString(\`linoleic-acid_100g\`)),
  toFloat64OrNull(toString(\`arachidonic-acid_100g\`)),
  toFloat64OrNull(toString(\`gamma-linolenic-acid_100g\`)),
  toFloat64OrNull(toString(\`dihomo-gamma-linolenic-acid_100g\`)),
  toFloat64OrNull(toString(\`oleic-acid_100g\`)),
  toFloat64OrNull(toString(\`elaidic-acid_100g\`)),
  toFloat64OrNull(toString(\`gondoic-acid_100g\`)),
  toFloat64OrNull(toString(\`mead-acid_100g\`)),
  toFloat64OrNull(toString(\`erucic-acid_100g\`)),
  toFloat64OrNull(toString(\`nervonic-acid_100g\`)),
  toFloat64OrNull(toString(\`trans-fat_100g\`)),
  toFloat64OrNull(toString(cholesterol_100g)),
  toFloat64OrNull(toString(carbohydrates_100g)),
  toFloat64OrNull(toString(sugars_100g)),
  toFloat64OrNull(toString(\`added-sugars_100g\`)),
  toFloat64OrNull(toString(sucrose_100g)),
  toFloat64OrNull(toString(glucose_100g)),
  toFloat64OrNull(toString(fructose_100g)),
  toFloat64OrNull(toString(galactose_100g)),
  toFloat64OrNull(toString(lactose_100g)),
  toFloat64OrNull(toString(maltose_100g)),
  toFloat64OrNull(toString(maltodextrins_100g)),
  toFloat64OrNull(toString(starch_100g)),
  toFloat64OrNull(toString(polyols_100g)),
  toFloat64OrNull(toString(erythritol_100g)),
  toFloat64OrNull(toString(fiber_100g)),
  toFloat64OrNull(toString(\`soluble-fiber_100g\`)),
  toFloat64OrNull(toString(\`insoluble-fiber_100g\`)),
  toFloat64OrNull(toString(proteins_100g)),
  toFloat64OrNull(toString(casein_100g)),
  toFloat64OrNull(toString(\`serum-proteins_100g\`)),
  toFloat64OrNull(toString(nucleotides_100g)),
  toFloat64OrNull(toString(salt_100g)),
  toFloat64OrNull(toString(\`added-salt_100g\`)),
  toFloat64OrNull(toString(sodium_100g)),
  toFloat64OrNull(toString(alcohol_100g)),
  toFloat64OrNull(toString(\`vitamin-a_100g\`)),
  toFloat64OrNull(toString(\`beta-carotene_100g\`)),
  toFloat64OrNull(toString(\`vitamin-d_100g\`)),
  toFloat64OrNull(toString(\`vitamin-e_100g\`)),
  toFloat64OrNull(toString(\`vitamin-k_100g\`)),
  toFloat64OrNull(toString(\`vitamin-c_100g\`)),
  toFloat64OrNull(toString(\`vitamin-b1_100g\`)),
  toFloat64OrNull(toString(\`vitamin-b2_100g\`)),
  toFloat64OrNull(toString(\`vitamin-pp_100g\`)),
  toFloat64OrNull(toString(\`vitamin-b6_100g\`)),
  toFloat64OrNull(toString(\`vitamin-b9_100g\`)),
  toFloat64OrNull(toString(folates_100g)),
  toFloat64OrNull(toString(\`vitamin-b12_100g\`)),
  toFloat64OrNull(toString(biotin_100g)),
  toFloat64OrNull(toString(\`pantothenic-acid_100g\`)),
  toFloat64OrNull(toString(silica_100g)),
  toFloat64OrNull(toString(bicarbonate_100g)),
  toFloat64OrNull(toString(potassium_100g)),
  toFloat64OrNull(toString(chloride_100g)),
  toFloat64OrNull(toString(calcium_100g)),
  toFloat64OrNull(toString(phosphorus_100g)),
  toFloat64OrNull(toString(iron_100g)),
  toFloat64OrNull(toString(magnesium_100g)),
  toFloat64OrNull(toString(zinc_100g)),
  toFloat64OrNull(toString(copper_100g)),
  toFloat64OrNull(toString(manganese_100g)),
  toFloat64OrNull(toString(fluoride_100g)),
  toFloat64OrNull(toString(selenium_100g)),
  toFloat64OrNull(toString(chromium_100g)),
  toFloat64OrNull(toString(molybdenum_100g)),
  toFloat64OrNull(toString(iodine_100g)),
  toFloat64OrNull(toString(caffeine_100g)),
  toFloat64OrNull(toString(taurine_100g)),
  toFloat64OrNull(toString(ph_100g)),
  toFloat64OrNull(toString(\`fruits-vegetables-nuts_100g\`)),
  toFloat64OrNull(toString(\`fruits-vegetables-nuts-dried_100g\`)),
  toFloat64OrNull(toString(\`fruits-vegetables-nuts-estimate_100g\`)),
  toFloat64OrNull(toString(\`fruits-vegetables-nuts-estimate-from-ingredients_100g\`)),
  toFloat64OrNull(toString(\`collagen-meat-protein-ratio_100g\`)),
  toFloat64OrNull(toString(cocoa_100g)),
  toFloat64OrNull(toString(chlorophyl_100g)),
  toFloat64OrNull(toString(\`carbon-footprint_100g\`)),
  toFloat64OrNull(toString(\`carbon-footprint-from-meat-or-fish_100g\`)),
  toFloat64OrNull(toString(\`nutrition-score-fr_100g\`)),
  toFloat64OrNull(toString(\`nutrition-score-uk_100g\`)),
  toFloat64OrNull(toString(\`glycemic-index_100g\`)),
  toFloat64OrNull(toString(\`water-hardness_100g\`)),
  toFloat64OrNull(toString(choline_100g)),
  toFloat64OrNull(toString(phylloquinone_100g)),
  toFloat64OrNull(toString(\`beta-glucan_100g\`)),
  toFloat64OrNull(toString(inositol_100g)),
  toFloat64OrNull(toString(carnitine_100g)),
  toFloat64OrNull(toString(sulphate_100g)),
  toFloat64OrNull(toString(nitrate_100g)),
  toFloat64OrNull(toString(acidity_100g)),
  toFloat64OrNull(toString(\`carbohydrates-total_100g\`))
FROM file(
  '${FULL_PATH}',
  'TSVWithNames'
)
SETTINGS
  input_format_null_as_default = 1,
  format_csv_delimiter = '\t',
  input_format_allow_errors_num = 1000,
  input_format_allow_errors_ratio = 0.01;
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


echo "Checking column stats..."
clickhouse-client -h localhost \
  --user "${CLICKHOUSE_USER}" \
  --password "${CLICKHOUSE_PASSWORD}" \
  -q "SELECT name, type FROM system.columns WHERE database = 'foodfacts' AND table = 'products'" \
  | while read -r column type; do

  # Escape column name for ClickHouse
  escaped_column="\`${column}\`"
  
  echo -n "Column: ${column} (${type}) "
  
  # Get distinct count
  distinct_count=$(clickhouse-client -h localhost \
    --user "${CLICKHOUSE_USER}" \
    --password "${CLICKHOUSE_PASSWORD}" \
    -q "SELECT countDistinct(${escaped_column}) FROM foodfacts.products FORMAT TSV")
  
  echo -n "| Distinct: ${distinct_count} "
  
  # Get non-null count
  non_null=$(clickhouse-client -h localhost \
    --user "${CLICKHOUSE_USER}" \
    --password "${CLICKHOUSE_PASSWORD}" \
    -q "SELECT countIf(${escaped_column} IS NOT NULL) FROM foodfacts.products FORMAT TSV")
  
  echo "| Non-null: ${non_null}"
done


echo "Initialization completed!"
