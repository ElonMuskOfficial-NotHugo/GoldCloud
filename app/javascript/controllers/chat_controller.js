import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["chatTitle", "modal"];

  openModal() {
    console.log("Opening modal");
    this.modalTarget.style.display = "block";
  }

  closeModal() {
    console.log("Closing modal");
    this.modalTarget.style.display = "none";
  }

  createChat() {
    const title = this.chatTitleTarget.value.trim();

    if (title === "") {
      alert("Please enter an order ID or subject for the chat.");
      return;
    }
    fetch("/chats", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
      },
      body: JSON.stringify({
        chat: {
          title: title,
        },
      }),
    })
      .then((response) => {
        if (response.ok) {
          this.closeModal();
          window.location.reload();
        } else {
          alert("Failed to create chat. Please try again.");
        }
      });
  }
}
