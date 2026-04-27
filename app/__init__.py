from flask import Flask

from app.config.config import Config
from app.api.routes.home_routes import home
from app.api.routes.user_routes import user
from app.api.routes.book_routes import books
from app.api.routes.lending_routes import lending
from app.api.routes.inbox_routes import inbox


def create_app():
    app = Flask(__name__)
    app.config["SECRET_KEY"] = Config.SECRET_KEY

    app.register_blueprint(home)
    app.register_blueprint(user)
    app.register_blueprint(books)
    app.register_blueprint(lending)
    app.register_blueprint(inbox)

    return app
