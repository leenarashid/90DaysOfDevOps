from flask import Blueprint, render_template, request, flash, redirect, url_for
from flask_login import login_required, current_user
from functools import wraps
from app import db
from app.models import Order, Restaurant, User

admin_bp = Blueprint('admin', __name__)


def admin_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        if not current_user.is_authenticated or not current_user.is_admin:
            flash('Admin access required.', 'error')
            return redirect(url_for('main.index'))
        return f(*args, **kwargs)
    return decorated


@admin_bp.route('/dashboard')
@login_required
@admin_required
def dashboard():
    total_orders = Order.query.count()
    pending = Order.query.filter_by(status='Pending').count()
    delivered = Order.query.filter_by(status='Delivered').count()
    revenue = db.session.query(db.func.sum(Order.total_amount)).filter_by(status='Delivered').scalar() or 0
    recent_orders = Order.query.order_by(Order.created_at.desc()).limit(10).all()
    return render_template('admin/dashboard.html',
                           total_orders=total_orders, pending=pending,
                           delivered=delivered, revenue=revenue,
                           recent_orders=recent_orders)


@admin_bp.route('/orders')
@login_required
@admin_required
def orders():
    status_filter = request.args.get('status', '')
    query = Order.query.order_by(Order.created_at.desc())
    if status_filter:
        query = query.filter_by(status=status_filter)
    all_orders = query.all()
    statuses = ['Pending', 'Confirmed', 'Preparing', 'Out for Delivery', 'Delivered', 'Cancelled']
    return render_template('admin/orders.html', orders=all_orders,
                           statuses=statuses, status_filter=status_filter)


@admin_bp.route('/orders/<int:order_id>/update', methods=['POST'])
@login_required
@admin_required
def update_order_status(order_id):
    order = Order.query.get_or_404(order_id)
    new_status = request.form.get('status')
    valid_statuses = ['Pending', 'Confirmed', 'Preparing', 'Out for Delivery', 'Delivered', 'Cancelled']
    if new_status in valid_statuses:
        order.status = new_status
        db.session.commit()
        flash(f'Order #{order_id} status updated to {new_status}.', 'success')
    return redirect(url_for('admin.orders'))


@admin_bp.route('/users')
@login_required
@admin_required
def users():
    all_users = User.query.order_by(User.created_at.desc()).all()
    return render_template('admin/users.html', users=all_users)
