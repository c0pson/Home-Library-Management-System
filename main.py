"""
Application entry point.

Initializes the Flask app via the factory function
and starts the development server.
"""

from app import create_app

app = create_app()

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
