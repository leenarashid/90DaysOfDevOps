from flask import Blueprint, render_template, request, flash, redirect, url_for, jsonify
from flask_login import login_required, current_user
from datetime import datetime, timedelta
from app import db
from app.models import Order, OrderItem, MenuItem, Restaurant

orders_bp = Blueprint('orders', __name__)


@orders_bp.route('/place', methods=['POST'])
@login_required
def place_order():
    restaurant_id = request.form.get('restaurant_id', type=int)
    delivery_address = request.form.get('delivery_address', '').strip()
    notes = request.form.get('notes', '').strip()

    if not delivery_address:
        delivery_address = current_user.address or 'Address not provided'

    restaurant = Restaurant.query.get_or_404(restaurant_id)
    item_ids = request.form.getlist('item_ids')
    quantities = request.form.getlist('quantities')

    if not item_ids:
        flash('Your cart is empty!', 'error')
        return redirect(url_for('main.restaurant_detail', restaurant_id=restaurant_id))

    order = Order(
        user_id=current_user.id,
        restaurant_id=restaurant_id,
        delivery_address=delivery_address,
        notes=notes,
        delivery_fee=restaurant.delivery_fee,
        total_amount=0,
        status='Pending',
        estimated_delivery=(datetime.utcnow() + timedelta(minutes=40)).strftime('%I:%M %p')
    )
    db.session.add(order)
    db.session.flush()

    total = 0
    for item_id, qty in zip(item_ids, quantities):
        qty = int(qty) if int(qty) > 0 else 1
        menu_item = MenuItem.query.get(item_id)
        if menu_item and menu_item.restaurant_id == restaurant_id:
            oi = OrderItem(order_id=order.id, menu_item_id=menu_item.id,
                           quantity=qty, unit_price=menu_item.price)
            db.session.add(oi)
            total += menu_item.price * qty

    order.total_amount = total + restaurant.delivery_fee
    db.session.commit()

    flash('🎉 Order placed successfully!', 'success')
    return redirect(url_for('orders.order_detail', order_id=order.id))


@orders_bp.route('/<int:order_id>')
@login_required
def order_detail(order_id):
    order = Order.query.get_or_404(order_id)
    if order.user_id != current_user.id and not current_user.is_admin:
        flash('Access denied.', 'error')
        return redirect(url_for('main.index'))
    return render_template('orders/detail.html', order=order)


@orders_bp.route('/history')
@login_required
def history():
    orders = Order.query.filter_by(user_id=current_user.id).order_by(Order.created_at.desc()).all()
    return render_template('orders/history.html', orders=orders)


@orders_bp.route('/<int:order_id>/cancel', methods=['POST'])
@login_required
def cancel_order(order_id):
    order = Order.query.get_or_404(order_id)
    if order.user_id != current_user.id:
        flash('Access denied.', 'error')
        return redirect(url_for('main.index'))
    if order.status in ('Pending', 'Confirmed'):
        order.status = 'Cancelled'
        db.session.commit()
        flash('Order cancelled.', 'info')
    else:
        flash('Order cannot be cancelled at this stage.', 'error')
    return redirect(url_for('orders.order_detail', order_id=order_id))
