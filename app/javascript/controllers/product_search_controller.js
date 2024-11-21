import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["searchInput", "searchResults", "searchResult",
                    "selectedProducts", "productTemplate"]

  connect() {
    // Hide search results initially
    this.hideSearchResults()

    // Close search results when clicking outside
    document.addEventListener('click', (event) => {
      if (!this.element.contains(event.target)) {
        this.hideSearchResults()
      }
    })
  }

  search() {
    const query = this.searchInputTarget.value.toLowerCase()

    if (query.length < 1) {
      this.hideSearchResults()
      return
    }

    this.searchResultTargets.forEach(result => {
      const productName = result.dataset.productName
      if (productName.includes(query)) {
        result.style.display = 'block'
      } else {
        result.style.display = 'none'
      }
    })

    this.showSearchResults()
  }

  selectProduct(event) {
    const searchResult = event.currentTarget
    const productId = searchResult.dataset.productId

    // Check if product is already selected
    if (this.isProductSelected(productId)) {
      return
    }

    // Clone the template
    const template = this.productTemplateTarget.content.cloneNode(true)
    const productItem = template.querySelector('.product-item')

    // Set product details
    productItem.dataset.productId = productId
    productItem.querySelector('.product-name').textContent =
      `${searchResult.dataset.productName} - R${searchResult.dataset.productPrice}/g`
    productItem.querySelector('input[type="hidden"]').value = productId

    // Add to selected products
    this.selectedProductsTarget.appendChild(productItem)

    // Clear and hide search
    this.searchInputTarget.value = ''
    this.hideSearchResults()
  }

  removeProduct(event) {
    event.preventDefault()
    event.currentTarget.closest('.product-item').remove()
  }

  showSearchResults() {
    this.searchResultsTarget.style.display = 'block'
  }

  hideSearchResults() {
    this.searchResultsTarget.style.display = 'none'
  }

  isProductSelected(productId) {
    return this.selectedProductsTarget.querySelector(
      `.product-item[data-product-id="${productId}"]`
    ) !== null
  }
}
