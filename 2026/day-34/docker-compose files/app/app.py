import os
import psycopg2
import redis
from flask import Flask

app = Flask(__name__)

# Cache setup (Redis)
cache = redis.Redis(host='cache', port=6379)

# Database setup (Postgres)
def get_db_connection():
    conn = psycopg2.connect(
        host='db',
        database=os.environ.get('POSTGRES_DB', 'testdb'),
        user=os.environ.get('POSTGRES_USER', 'user'),
        password=os.environ.get('POSTGRES_PASSWORD', 'password')
    )
    return conn

@app.route('/')
def hello():
    cache.incr('hits')
    hits = cache.get('hits').decode('utf-8')
    
    db_status = "Not Connected"
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('SELECT version()')
        db_version = cur.fetchone()[0]
        cur.close()
        conn.close()
        db_status = f"Connected to {db_version.split()[0]} {db_version.split()[1]}"
    except Exception as e:
        db_status = f"Database connection failed: {str(e)}"

    return f"Hello World! This page has been viewed {hits} times.\nDatabase Status: {db_status}\n"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
