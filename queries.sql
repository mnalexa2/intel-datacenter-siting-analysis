-- ============================================
-- Intel Data Center Siting Analysis
-- ============================================

-- Task 1A: Net energy production by region
-- Net production = total energy generated minus total demand
SELECT
    region,
    SUM(net_generation - demand) AS sum_total
FROM
    intel.energy_data
GROUP BY
    region
ORDER BY
    sum_total DESC;

-- Task 1B: Total renewable energy production by region
-- Renewable = hydropower + wind + solar
SELECT
    region,
    SUM(hydropower_and_pumped_storage + wind + solar) AS sum_total_renewable
FROM
    intel.energy_data
GROUP BY
    region
ORDER BY
    sum_total_renewable DESC;

-- Task 1C: Renewable energy as a percentage of total generation
SELECT
    region,
    SUM(hydropower_and_pumped_storage + wind + solar) / SUM(net_generation) * 100 AS total_percentage
FROM
    intel.energy_data
GROUP BY
    region
ORDER BY
    total_percentage DESC;

-- Task 2: Combined renewable + fossil fuel dataset for visualization
SELECT
    date,
    region,
    all_petroleum_products + coal + natural_gas + nuclear + other_fuel_sources AS energy_generated_mw,
    'fossil fuels' AS energy_type
FROM
    intel.energy_data
UNION
SELECT
    date,
    region,
    hydropower_and_pumped_storage + solar + wind AS energy_generated_mw,
    'renewable energy' AS energy_type
FROM
    intel.energy_data;

-- Task 3A: Join power plant metadata with plant-level energy production
SELECT
    *
FROM
    intel.power_plants AS p
    INNER JOIN intel.energy_by_plant AS e ON p.plant_code = e.plant_code;

-- Task 3B: Count of renewable power plants by region
WITH plant_info_table AS (
    SELECT
        *
    FROM
        intel.power_plants AS p
        INNER JOIN intel.energy_by_plant AS e ON p.plant_code = e.plant_code
)
SELECT
    region,
    energy_type,
    COUNT(*)
FROM
    plant_info_table
WHERE
    energy_type = 'renewable_energy'
GROUP BY
    region,
    energy_type
ORDER BY
    COUNT DESC;

-- Task 3C/D: Solar Photovoltaic plant count and total energy by region
-- (filtered to regions with 50+ solar plants to assess plant efficiency/size)
WITH plant_info_table AS (
    SELECT
        *
    FROM
        intel.power_plants AS p
        INNER JOIN intel.energy_by_plant AS e ON p.plant_code = e.plant_code
)
SELECT
    region,
    primary_technology,
    COUNT(*) AS n_total_power_plants,
    SUM(energy_generated_mw) AS sum_total_energy
FROM
    plant_info_table
WHERE
    primary_technology = 'Solar Photovoltaic'
GROUP BY
    region,
    primary_technology
HAVING COUNT(primary_technology) >= 50
ORDER BY
    n_total_power_plants DESC;

-- LevelUp: Hourly renewable energy trends by region
SELECT
    region,
    date_part('hour', time_at_end_of_hour) AS hour,
    SUM(hydropower_and_pumped_storage + solar + wind) AS total_renewable_energy
FROM
    intel.energy_data
GROUP BY
    region,
    date_part('hour', time_at_end_of_hour)
ORDER BY
    region;
