from flask_restplus import Api

from flaskr.api.todo import todo_namespace
from flaskr.api.user import user_namespace

api = Api(
    title='Test API',
    version='1.0',
    description='Swaggerを統合したREST APIのサンプル'
)

api.add_namespace(todo_namespace)
api.add_namespace(user_namespace)
