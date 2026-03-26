from app import create_app, db
from app.models import User, Restaurant, MenuItem, Order, OrderItem

app = create_app()

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
        from app.seed import seed_data
        seed_data()
    app.run(host='0.0.0.0', port=5000, debug=True)
