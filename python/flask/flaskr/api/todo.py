from flask_restplus import Namespace, fields, Resource

from flaskr.models.todo import ToDo, db

todo_namespace = Namespace('todo',
                           description='ToDo endpoint')

todo = todo_namespace.model('ToDo', {
    'user_id': fields.Integer(
        required=True,
        description='Todo',
        example=0),

    'id': fields.Integer(
        required=True,
        description='ToDo ID',
        example=1),

    'title': fields.String(
        required=True,
        description='ToDoタイトル',
        example='起きる'
    ),

    'description': fields.String(
        required=True,
        description='ToDoの詳細',
        example='朝7時に起きたい'
    )
})


@todo_namespace.route('/')
class TodoList(Resource):
    @todo_namespace.marshal_list_with(todo)
    def get(self):
        """
        ToDo一覧表示
        """
        return ToDo.query.all()

    @todo_namespace.marshal_with(todo)
    @todo_namespace.expect(todo, validate=True)
    def post(self):
        """
        ToDo登録
        """
        pass


@todo_namespace.route('/<int:todo_id>')
class TodoController(Resource):
    @todo_namespace.marshal_with(todo, code=201)
    @todo_namespace.response(404, 'The Todo is not Found')
    def get(self, todo_id):
        return ToDo.query.filter(ToDo.id == todo_id).first_or_404()

    def delete(self, todo_id):
        """
        ToDo削除
        """
        # 見つからなかったときの処理してないけど許して
        target_todo = ToDo.query.filter(ToDo.id == todo_id).first()
        db.session.delete(target_todo)
        return {'message': 'Success'}, 200
