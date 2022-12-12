
import pandas as pd

date_aux = pd.to_datetime(int('1331856000000'), utc=False, unit='s')

print(date_aux.strftime('%Y-%m-%d'))
print(date_aux.strftime('%H:%M:%S'))
