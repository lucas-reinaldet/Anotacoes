
from datetime import datetime, date
import pytz
import pandas as pd

date_hour = datetime.now(pytz.timezone('America/Sao_Paulo'))

print(date_hour.strftime('%Y-%m-%d'))
print(date_hour.strftime('%H:%M:%S'))

# date_aux = pd.to_datetime(int(valor[1]), utc=False, unit='s')