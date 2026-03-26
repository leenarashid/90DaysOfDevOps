from flask import Blueprint, render_template, request
from app.models import Restaurant, MenuItem

main_bp = Blueprint('main', __name__)


@main_bp.route('/')
def index():
    cuisine_filter = request.args.get('cuisine', '')
    search = request.args.get('search', '').strip()
    query = Restaurant.query.filter_by(is_active=True)
    if cuisine_filter:
        query = query.filter(Restaurant.cuisine.ilike(f'%{cuisine_filter}%'))
    if search:
        query = query.filter(
            Restaurant.name.ilike(f'%{search}%') |
            Restaurant.cuisine.ilike(f'%{search}%') |
            Restaurant.description.ilike(f'%{search}%')
        )
    restaurants = query.all()
    cuisines = [r.cuisine for r in Restaurant.query.with_entities(Restaurant.cuisine).distinct()]
    return render_template('main/index.html', restaurants=restaurants, cuisines=cuisines,
                           cuisine_filter=cuisine_filter, search=search)


@main_bp.route('/restaurant/<int:restaurant_id>')
def restaurant_detail(restaurant_id):
    restaurant = Restaurant.query.get_or_404(restaurant_id)
    categories = {}
    for item in restaurant.menu_items:
        if item.is_available:
            categories.setdefault(item.category, []).append(item)
    return render_template('main/restaurant.html', restaurant=restaurant, categories=categories)
