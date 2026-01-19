
# Supply Chain & Logistics Operations Analytics
import pandas as pd
import matplotlib.pyplot as plt

# Load dataset
df = pd.read_csv("Inventory_SupplyChain_Dataset.csv")

# Demand–Supply Gap
df["demand_supply_gap"] = df["Demand_Forecast"] - df["Inventory_Level"]

# KPI Calculations
stockout_rate = df["Stockout_Flag"].mean() * 100
avg_lead_time = df["Lead_Time_Days"].mean()

print(f"Stock-out Rate: {stockout_rate:.2f}%")
print(f"Average Lead Time: {avg_lead_time:.2f} days")

# Supplier Performance
supplier_perf = (
    df.groupby("Supplier_ID")["Lead_Time_Days"]
    .agg(["mean", "max", "min"])
    .sort_values(by="mean", ascending=False)
)

print("\nSupplier Lead Time Summary:")
print(supplier_perf.head())

# Visualization
plt.figure()
df.groupby("Warehouse_ID")["Stockout_Flag"].mean().plot(kind="bar")
plt.title("Stock-out Rate by Warehouse")
plt.ylabel("Stock-out Rate")
plt.show()
