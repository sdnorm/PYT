import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  navigate(event) {
    event.preventDefault()
    const url = event.currentTarget.getAttribute("href")
    
    fetch(url, {
      headers: {
        "Accept": "text/vnd.turbo-stream.html"
      }
    })
  }
}