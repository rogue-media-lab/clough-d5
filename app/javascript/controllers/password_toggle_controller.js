import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "eyeOpen", "eyeClosed"]

  connect() {
    // Start hidden (password type) — show the "closed eye" icon
    this.eyeOpenTarget.classList.add("hidden")
    this.eyeClosedTarget.classList.remove("hidden")
  }

  toggle() {
    const input = this.inputTarget
    if (input.type === "password") {
      input.type = "text"
      this.eyeOpenTarget.classList.remove("hidden")
      this.eyeClosedTarget.classList.add("hidden")
    } else {
      input.type = "password"
      this.eyeOpenTarget.classList.add("hidden")
      this.eyeClosedTarget.classList.remove("hidden")
    }
  }
}
