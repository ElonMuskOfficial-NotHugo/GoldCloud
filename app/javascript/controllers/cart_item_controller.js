import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["quantity"]
  static values = {
    itemId: Number,
    productId: Number
  }

  increase() {
    this.updateQuantity(1)
  }

  decrease() {
    this.updateQuantity(-1)
  }

  updateQuantity(change) {
    const currentQuantity = parseInt(this.quantityTarget.textContent)
    const newQuantity = currentQuantity + change

    if (newQuantity > 0) {
      fetch(`/order_items/${this.itemIdValue}`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({ order_item: { quantity: newQuantity } })
      })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          this.quantityTarget.textContent = newQuantity
          // Update total price if needed
          this.dispatch("sendNewTotal", { detail: { newTotal: data.total } })
        } else {
          console.error('Failed to update quantity')
        }
      })
    } else if (newQuantity === 0) {
      this.removeItem()
    }
  }

  removeItem() {
    fetch(`/products/${this.productIdValue}/remove_from_cart`, {
      method: 'DELETE',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      }
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        this.dispatch("sendNewTotal", { detail: { newTotal: data.total } })
        this.element.remove()
        // Update cart total if needed
      } else {
        console.error('Failed to remove item')
      }
    })
  }
}
