import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["total"]

  updateTotal({ detail: { newTotal } }) {
    // console.log(newTotal)
    this.totalTarget.textContent = `Total: R${Math.round(newTotal)}`
  }
}
