import { Application } from "@hotwired/stimulus"
import ChatController from "./chat_controller";

const application = Application.start()

application.register("chat", ChatController)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
