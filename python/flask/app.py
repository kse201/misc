from flask import Flask, url_for, request
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello world'

@app.route('/user/<username>')
def show_user_profile(username):
    return 'User %s' % username 

@app.route('/post/<int:post_id>')
def show_post(post_id):
    return 'Post %d' % post_id

@app.route('/path/<path:subpath>')
def show_subpath(subpath):
    return 'Subpath %s' % subpath

@app.route('/projects/')
def projects():
    return 'The project page'

@app.route('/about')
def about():
    return 'The about page'

@app.route('/')
def index():
    return 'index'

def do_the_login():
    raise NotImplementedError

def show_the_login_form():
    raise NotImplementedError

@app.route('/login', methods=['GET' 'POST'])
def login():
    if request.method == 'POST':
        return do_the_login()
    else:
        return show_the_login_form()

@app.route('/user/<username>')
def profile(username):
    return '{}\'s profile'.format(username)

with app.test_request_context():
    print(url_for('index'))
    print(url_for('login'))
    print(url_for('login', next='/'))
    print(url_for('profile', username='John Doe'))
