import pandas as pd
# import pymysql
from sqlalchemy import create_engine
host = 'fireteam108c-db.ctq6oauek6z5.us-east-2.rds.amazonaws.com:3306'
user = 'admin108c'
password = 'fireteam108c'
database = 'amazon_books'
engine = create_engine(f'mysql+pymysql://{user}:{password}@{host}/{database}')
connection = engine.connect()
# books_data_raw = pd.read_csv('books_data.csv')
# books_data_raw.to_sql('books_data_raw', con=engine, if_exists='replace', index=False)
books_rating_raw = pd.read_csv('Books_rating.csv')
print("migration started")
books_rating_raw.to_sql('books_rating_raw', con=connection, chunksize=1000, if_exists='replace', index=False, method='multi')
connection.close()
print("migration completed")