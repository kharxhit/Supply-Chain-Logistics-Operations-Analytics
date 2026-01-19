
-- Supply Chain & Logistics Operations Analytics
-- Inventory_SupplyChain_Dataset.sql

-- 1. Inventory Health & Stock-out Rate
SELECT 
    Warehouse_ID,
    COUNT(DISTINCT Product_ID) AS total_products,
    AVG(Inventory_Level) AS avg_inventory,
    SUM(CASE WHEN Stockout_Flag = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS stockout_rate_pct
FROM inventory_data
GROUP BY Warehouse_ID;

-- 2. Reorder Point Effectiveness
SELECT
    Product_ID,
    AVG(Inventory_Level) AS avg_inventory,
    AVG(Reorder_Point) AS avg_reorder_point,
    SUM(CASE WHEN Inventory_Level < Reorder_Point THEN 1 ELSE 0 END) AS below_reorder_count
FROM inventory_data
GROUP BY Product_ID;

-- 3. Lead-Time Variability by Supplier
SELECT
    Supplier_ID,
    AVG(Lead_Time_Days) AS avg_lead_time,
    MAX(Lead_Time_Days) - MIN(Lead_Time_Days) AS lead_time_variability
FROM inventory_data
GROUP BY Supplier_ID;

-- 4. Demand–Supply Gap Analysis
SELECT
    Warehouse_ID,
    SUM(Demand_Forecast) AS total_demand,
    SUM(Inventory_Level) AS total_inventory,
    SUM(Demand_Forecast) - SUM(Inventory_Level) AS demand_supply_gap
FROM inventory_data
GROUP BY Warehouse_ID;
