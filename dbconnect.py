import pandas as pd
import pymysql
from sqlalchemy import create_engine




def initialize_connection():
	host = 'fireteam108c-db.ctq6oauek6z5.us-east-2.rds.amazonaws.com:3306'
	user = 'admin108c'
	password = 'fireteam108c'
	database = 'amazon_books'
	engine = create_engine(f'mysql+pymysql://{user}:{password}@{host}/{database}')
	connection = engine.connect()
	return connection


