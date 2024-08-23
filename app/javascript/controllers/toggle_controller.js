import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = [ "content", "button" ]

  connect() {

  }

  toggle() {
    this.contentTarget.classList.toggle('hidden')
    this.buttonTarget.textContent = this.contentTarget.classList.contains("hidden") ? "Show Description" : "Hide Description"

  }

}
