from flask import Flask, render_template, request, redirect, url_for
from models import db, Order  # make sure models.py is in the same folder

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///food.db'  # SQLite for simplicity
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db.init_app(app)

# Create tables safely without using before_first_request
with app.app_context():
    db.create_all()

@app.route('/')
def index():
    orders = Order.query.all()
    return render_template('index.html', orders=orders)

@app.route('/order', methods=['POST'])
def order():
    customer = request.form['customer']
    food = request.form['food']
    new_order = Order(customer=customer, food=food)
    db.session.add(new_order)
    db.session.commit()
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)