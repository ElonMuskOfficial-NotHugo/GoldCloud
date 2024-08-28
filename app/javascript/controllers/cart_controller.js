import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["total"]

  updateTotal({ detail: { newTotal } }) {
    // console.log(newTotal)
    this.totalTarget.innerHTML = `Total <strong>R${Math.round(newTotal)}</strong>`
  }
}
