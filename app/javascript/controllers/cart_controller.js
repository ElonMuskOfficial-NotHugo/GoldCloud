import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["total"]

  connect() {
    console.log("Cart controller connected")
    console.log(this.totalTarget.textContent)
  }

  updateTotal(newTotal) {
    console.log("updated!")
    this.totalTarget.textContent = `Total: ${newTotal.toFixed(2)}`
  }
}
