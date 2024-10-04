import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]

  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      const query = this.inputTarget.value
      fetch(`/items?query=${encodeURIComponent(query)}`, {
        headers: { "Accept": "text/html" }
      })
        .then(response => response.text())
        .then(html => {
          this.resultsTarget.innerHTML = html
        })
    }, 300) // Debounce for 300ms
  }
}
