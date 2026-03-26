from app import db
from app.models import User, Restaurant, MenuItem


def seed_data():
    # Only seed if empty
    if User.query.first():
        return

    # Admin user
    admin = User(name='Admin', email='admin@deliveroo.com', phone='555-0000',
                 address='123 Admin St', is_admin=True)
    admin.set_password('admin123')
    db.session.add(admin)

    # Demo customer
    customer = User(name='Jane Doe', email='jane@example.com', phone='555-1234',
                    address='456 Oak Avenue, Springfield')
    customer.set_password('password123')
    db.session.add(customer)

    # Restaurants
    restaurants = [
        Restaurant(
            name='Burger Palace',
            description='Gourmet burgers crafted with 100% Angus beef and fresh locally-sourced ingredients.',
            cuisine='American',
            image_url='https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600&q=80',
            rating=4.8,
            delivery_time='20-30 min',
            delivery_fee=1.99,
            min_order=12.00
        ),
        Restaurant(
            name='Sakura Sushi',
            description='Authentic Japanese cuisine with the freshest fish flown in daily from Tsukiji market.',
            cuisine='Japanese',
            image_url='https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=600&q=80',
            rating=4.9,
            delivery_time='30-45 min',
            delivery_fee=2.99,
            min_order=20.00
        ),
        Restaurant(
            name='Mama Rosa\'s Pizza',
            description='Traditional Neapolitan pizza baked in a wood-fired oven since 1985.',
            cuisine='Italian',
            image_url='https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600&q=80',
            rating=4.7,
            delivery_time='25-35 min',
            delivery_fee=2.49,
            min_order=15.00
        ),
        Restaurant(
            name='Spice Garden',
            description='Authentic Indian cuisine with aromatic spices and traditional family recipes.',
            cuisine='Indian',
            image_url='https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=600&q=80',
            rating=4.6,
            delivery_time='35-50 min',
            delivery_fee=2.99,
            min_order=18.00
        ),
        Restaurant(
            name='Green Bowl',
            description='Healthy bowls, salads, and wraps made with organic ingredients.',
            cuisine='Healthy',
            image_url='https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=600&q=80',
            rating=4.5,
            delivery_time='20-30 min',
            delivery_fee=1.49,
            min_order=10.00
        ),
    ]
    db.session.add_all(restaurants)
    db.session.flush()

    # Menu Items
    menu_items = [
        # Burger Palace
        MenuItem(restaurant_id=restaurants[0].id, name='Classic Smash Burger', price=12.99,
                 category='Burgers', description='Double smash patty, American cheese, pickles, special sauce',
                 image_url='https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&q=80'),
        MenuItem(restaurant_id=restaurants[0].id, name='BBQ Bacon Burger', price=14.99,
                 category='Burgers', description='Wagyu beef, crispy bacon, BBQ sauce, jalapeños',
                 image_url='https://images.unsplash.com/photo-1553979459-d2229ba7433b?w=400&q=80'),
        MenuItem(restaurant_id=restaurants[0].id, name='Veggie Burger', price=11.99,
                 category='Burgers', description='Plant-based patty, avocado, sprouts, vegan mayo',
                 image_url='https://images.unsplash.com/photo-1520072959219-c595dc870360?w=400&q=80'),
        MenuItem(restaurant_id=restaurants[0].id, name='Loaded Fries', price=6.99,
                 category='Sides', description='Crispy fries with cheese sauce, bacon bits, green onions',
                 image_url='https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=400&q=80'),
        MenuItem(restaurant_id=restaurants[0].id, name='Chocolate Milkshake', price=5.99,
                 category='Drinks', description='Thick creamy shake with premium chocolate ice cream',
                 image_url='https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=400&q=80'),

        # Sakura Sushi
        MenuItem(restaurant_id=restaurants[1].id, name='Dragon Roll', price=18.99,
                 category='Rolls', description='Shrimp tempura, avocado, topped with tuna & tobiko',
                 image_url='https://images.unsplash.com/photo-1617196034183-421b4040ed20?w=400&q=80'),
        MenuItem(restaurant_id=restaurants[1].id, name='Salmon Sashimi (8 pcs)', price=22.99,
                 category='Sashimi', description='Premium Atlantic salmon, served with wasabi & gari',
                 image_url='https://images.unsplash.com/photo-1559410545-0bdcd187e0a6?w=400&q=80'),
        MenuItem(restaurant_id=restaurants[1].id, name='Ramen Bowl', price=16.99,
                 category='Hot', description='Tonkotsu broth, chashu pork, soft egg, nori, bamboo shoots',
                 image_url='https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=400&q=80'),
        MenuItem(restaurant_id=restaurants[1].id, name='Edamame', price=5.99,
                 category='Appetizers', description='Steamed salted soybeans',
                 image_url='https://images.unsplash.com/photo-1547592180-85f173990554?w=400&q=80'),

        # Mama Rosa's Pizza
        MenuItem(restaurant_id=restaurants[2].id, name='Margherita Pizza', price=15.99,
                 category='Pizza', description='San Marzano tomato, fresh mozzarella, basil, EVOO',
                 image_url='https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400&q=80'),
        MenuItem(restaurant_id=restaurants[2].id, name='Pepperoni Pizza', price=17.99,
                 category='Pizza', description='Loaded with premium pepperoni and melted mozzarella',
                 image_url='https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&q=80'),
        MenuItem(restaurant_id=restaurants[2].id, name='Truffle Mushroom Pizza', price=19.99,
                 category='Pizza', description='Porcini mushrooms, truffle oil, fontina, rosemary',
                 image_url='https://images.unsplash.com/photo-1571407970349-bc81e7e96d47?w=400&q=80'),
        MenuItem(restaurant_id=restaurants[2].id, name='Tiramisu', price=8.99,
                 category='Desserts', description='Classic Italian dessert with mascarpone and espresso',
                 image_url='https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=400&q=80'),

        # Spice Garden
        MenuItem(restaurant_id=restaurants[3].id, name='Butter Chicken', price=16.99,
                 category='Mains', description='Tender chicken in rich tomato-cream masala sauce',
                 image_url='https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=400&q=80'),
        MenuItem(restaurant_id=restaurants[3].id, name='Lamb Biryani', price=19.99,
                 category='Rice', description='Fragrant basmati rice layered with slow-cooked lamb',
                 image_url='https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=400&q=80'),
        MenuItem(restaurant_id=restaurants[3].id, name='Garlic Naan (3 pcs)', price=4.99,
                 category='Bread', description='Freshly baked fluffy naan with garlic butter',
                 image_url='https://images.unsplash.com/photo-1574653853027-5382a3d23a15?w=400&q=80'),
        MenuItem(restaurant_id=restaurants[3].id, name='Mango Lassi', price=4.99,
                 category='Drinks', description='Creamy yogurt drink blended with Alphonso mangoes',
                 image_url='https://images.unsplash.com/photo-1553361371-9b22f78e8b1d?w=400&q=80'),

        # Green Bowl
        MenuItem(restaurant_id=restaurants[4].id, name='Acai Power Bowl', price=14.99,
                 category='Bowls', description='Açaí base, granola, banana, berries, honey drizzle',
                 image_url='https://images.unsplash.com/photo-1590301157890-4810ed352733?w=400&q=80'),
        MenuItem(restaurant_id=restaurants[4].id, name='Quinoa Salad', price=12.99,
                 category='Salads', description='Tri-color quinoa, roasted veggies, tahini dressing',
                 image_url='https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&q=80'),
        MenuItem(restaurant_id=restaurants[4].id, name='Green Goddess Wrap', price=11.99,
                 category='Wraps', description='Hummus, avocado, kale, cucumber, sprouts in spinach wrap',
                 image_url='https://images.unsplash.com/photo-1626700051175-6818013e1d4f?w=400&q=80'),
        MenuItem(restaurant_id=restaurants[4].id, name='Cold Brew Lemonade', price=4.99,
                 category='Drinks', description='House cold brew with fresh-squeezed lemon, honey',
                 image_url='https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=400&q=80'),
    ]
    db.session.add_all(menu_items)
    db.session.commit()
    print("OK - Database seeded successfully!")
