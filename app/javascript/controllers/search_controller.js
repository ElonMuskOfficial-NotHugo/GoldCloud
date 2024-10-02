import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "form", "input", "list" ]
  static values = { debounce: { type: Number, default: 300 } }

  connect() {
    this.debugMessage("Search controller connected")
  }

  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      // this.debugMessage("Searching...")
      this.formTarget.requestSubmit()
    }, this.debounceValue)
  }

  // debugMessage(message) {
  //   if (process.env.NODE_ENV === 'development') {
  //     console.log(message)
  //   }
  // }
}
