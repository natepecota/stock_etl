import requests
import json
import boto3
from datetime import datetime, timedelta
import pandas as pd
import pyarrow as pq
import awswrangler as wr

s3_client = boto3.client('s3')

url = 'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=MNMD&&outputsize=full&apikey=<API_KEY>'
r = requests.get(url)
data_raw = r.json()
data = json.dumps(data_raw, indent=4)

data = data_raw["Time Series (Daily)"]

df = pd.DataFrame(data)

# print(df)

#this step can be done in Snowflake using flatten
df = df.transpose()

# print(df)

# Reset the index and rename the resulting column
df = df.reset_index().rename(columns={"index":"stock_date"})

# print(df)

# Extract the symbol data from the Meta Data json
symbol = data_raw["Meta Data"]["2. Symbol"]

# Add a symbol column with the symbol data
df.insert(0, "symbol", symbol, True)

# print(df)

wr.s3.to_parquet(df=df,
                 path= 's3://<path/to_parquet_file/location/in_s3'
                )
