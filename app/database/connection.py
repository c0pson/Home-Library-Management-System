"""
PostgreSQL connection manager.

Provides get_connection() and close_connection() using psycopg2.
All repositories use this as their single entry point to the database.
"""
