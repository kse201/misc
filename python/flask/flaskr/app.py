from flask import Flask

from flaskr import settings
from flaskr.api import api
from flaskr.models import db

app = Flask(__name__)


def configure_app(flask_app: Flask) -> None:
    flask_app.config['SQLALCHEMY_DATABASE_URI'] = \
        settings.SQLALCHEMY_DATABASE_URI
    flask_app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = \
        settings.SQLALCHEMY_TRACK_MODIFICATIONS
    flask_app.config['SWAGGER_UI_DOC_EXPANSION'] = \
        settings.SWAGGER_UI_DOC_EXPANSION
    flask_app.config['RESTPLUS_VALIDATE'] = settings.RESTPLUS_VALIDATE


def initialize_app(flask_app: Flask) -> None:
    configure_app(flask_app)
    api.init_app(flask_app)
    db.init_app(flask_app)
    db.create_all(app=flask_app)


def main() -> None:
    initialize_app(app)
    app.run(host='0.0.0.0',
            port=settings.PORT,
            debug=settings.DEBUG)


if __name__ == '__main__':
    main()
