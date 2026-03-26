/* =====================================================
   SwiftBite – Cart & Order Logic
   ===================================================== */

const cart = {}; // { itemId: { name, price, qty } }

// Event delegation for add-to-cart buttons (reads data attrs from parent .menu-item)
document.addEventListener('click', function(e) {
  const btn = e.target.closest('.cart-add-btn');
  if (!btn) return;
  const item = btn.closest('.menu-item');
  if (!item) return;
  const id = item.dataset.id;
  const name = item.dataset.name;
  const price = item.dataset.price;
  if (id && name && price) addToCart(id, name, price);
});


function addToCart(id, name, price) {
  const floatPrice = parseFloat(price);
  if (cart[id]) {
    cart[id].qty++;
  } else {
    cart[id] = { name, price: floatPrice, qty: 1 };
  }
  renderCart();
  showAddedFeedback(id);
}

function removeFromCart(id) {
  if (cart[id]) {
    cart[id].qty--;
    if (cart[id].qty <= 0) delete cart[id];
    renderCart();
  }
}

function showAddedFeedback(id) {
  const btn = document.querySelector(`[data-id="${id}"] .add-to-cart`);
  if (btn) {
    btn.textContent = '✓';
    btn.style.background = '#10b981';
    setTimeout(() => {
      btn.textContent = '+';
      btn.style.background = '';
    }, 700);
  }
}

function renderCart() {
  const sidebar = document.getElementById('sidebarItems');
  const totals = document.getElementById('orderTotals');
  const deliverySection = document.getElementById('deliverySection');
  const startCta = document.getElementById('startCta');
  const cartFab = document.getElementById('cartFab');
  const cartCount = document.getElementById('cartCount');
  const cartFabTotal = document.getElementById('cartFabTotal');

  const items = Object.entries(cart);
  let subtotal = 0;

  if (sidebar) {
    if (items.length === 0) {
      sidebar.innerHTML = '<div class="cart-empty-msg">Add items to get started</div>';
      if (totals) totals.style.display = 'none';
      if (deliverySection) deliverySection.style.display = 'none';
      if (startCta) startCta.style.display = 'block';
      if (cartFab) cartFab.style.display = 'none';
    } else {
      sidebar.innerHTML = items.map(([id, item]) => {
        subtotal += item.price * item.qty;
        return `<div class="sidebar-item">
          <span class="sidebar-item-name">${item.name}</span>
          <span class="sidebar-item-qty">
            <button onclick="removeFromCart('${id}')">−</button>
            ${item.qty}
            <button onclick="addToCart('${id}','${item.name}','${item.price}')">+</button>
          </span>
          <span class="sidebar-item-price">$${(item.price * item.qty).toFixed(2)}</span>
        </div>`;
      }).join('');

      const deliveryFeeVal = typeof deliveryFee !== 'undefined' ? deliveryFee : 0;
      const total = subtotal + deliveryFeeVal;

      if (totals) {
        totals.style.display = 'block';
        document.getElementById('sidebarSubtotal').textContent = `$${subtotal.toFixed(2)}`;
        document.getElementById('sidebarTotal').textContent = `$${total.toFixed(2)}`;
      }
      if (deliverySection) deliverySection.style.display = 'flex';
      if (startCta) startCta.style.display = 'none';

      const totalItems = items.reduce((s, [, v]) => s + v.qty, 0);
      if (cartFab) {
        cartFab.style.display = 'block';
        if (cartCount) cartCount.textContent = totalItems;
        if (cartFabTotal) cartFabTotal.textContent = `$${total.toFixed(2)}`;
      }
    }
  }
}

function placeOrder(restaurantId, deliveryFeeAmt) {
  const items = Object.entries(cart);
  if (items.length === 0) {
    alert('Please add items to your order first.');
    return;
  }

  const address = document.getElementById('sidebarAddress')?.value?.trim();
  if (!address) {
    alert('Please enter a delivery address.');
    document.getElementById('sidebarAddress')?.focus();
    return;
  }

  const notes = document.getElementById('sidebarNotes')?.value?.trim() || '';
  const form = document.createElement('form');
  form.method = 'POST';
  form.action = '/orders/place';

  const fields = {
    restaurant_id: restaurantId,
    delivery_address: address,
    notes: notes
  };

  for (const [k, v] of Object.entries(fields)) {
    const inp = document.createElement('input');
    inp.type = 'hidden'; inp.name = k; inp.value = v;
    form.appendChild(inp);
  }

  for (const [id, item] of items) {
    const idInp = document.createElement('input');
    idInp.type = 'hidden'; idInp.name = 'item_ids'; idInp.value = id;
    form.appendChild(idInp);
    const qtyInp = document.createElement('input');
    qtyInp.type = 'hidden'; qtyInp.name = 'quantities'; qtyInp.value = item.qty;
    form.appendChild(qtyInp);
  }

  document.body.appendChild(form);
  form.submit();
}

// Flash auto-dismiss
setTimeout(() => {
  document.querySelectorAll('.flash').forEach(f => {
    f.style.transition = 'opacity .4s';
    f.style.opacity = '0';
    setTimeout(() => f.remove(), 400);
  });
}, 4000);

// Jinja2 enumerate shim
if (typeof enumerate === 'undefined') {
  window.enumerate = function(arr) {
    return arr.map((v, i) => [i, v]);
  };
}
