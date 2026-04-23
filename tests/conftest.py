"""
Shared pytest fixtures.

Provides reusable test setup: Flask test client, database
connections with automatic rollback, and sample data factories
(users, books, friendships). Auto discovered by pytest,
any test function can request these fixtures by parameter name.
"""
