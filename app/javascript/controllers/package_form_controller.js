import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["totalPrice"]

  connect() {
    this.updateTotalPrice()
  }

  increaseQuantity(event) {
    const input = event.target.previousElementSibling
    input.value = parseInt(input.value) + 1
    this.updateTotalPrice()
  }

  decreaseQuantity(event) {
    const input = event.target.nextElementSibling
    if (parseInt(input.value) > 0) {
      input.value = parseInt(input.value) - 1
      this.updateTotalPrice()
    }
  }

  updateTotalPrice() {
    let total = 0
    this.element.querySelectorAll('#product-list input[type="number"]').forEach(input => {
      const productCard = input.closest('.card')
      const price = parseFloat(productCard.querySelector('.card-text').textContent.replace('R', '').replace('/g', ''))
      total += price * parseInt(input.value)
    })
    this.totalPriceTarget.value = total.toFixed(2)
  }
}
