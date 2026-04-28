import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["canvas", "tab", "todayVisits", "todayViews", "weekVisits", "weekViews", "monthVisits", "monthViews", "totalVisits"]

  connect() {
    this.chart = null
    this.allVisits = JSON.parse(this.element.dataset.visits || "{}")
    this.allPageViews = JSON.parse(this.element.dataset.pageViews || "{}")

    this.initChart()
    this.filterByRange(30)
  }

  disconnect() {
    if (this.chart) {
      this.chart.destroy()
      this.chart = null
    }
  }

  initChart() {
    const Chart = window.Chart
    if (!Chart) {
      console.error("Chart.js not loaded")
      return
    }

    const ctx = this.canvasTarget.getContext("2d")

    this.chart = new Chart(ctx, {
      type: "line",
      data: {
        labels: [],
        datasets: [
          {
            label: "Visits",
            data: [],
            borderColor: "#C8902A",
            backgroundColor: "rgba(200, 144, 42, 0.1)",
            fill: true,
            tension: 0.3,
            pointRadius: 2,
            pointHoverRadius: 5,
            borderWidth: 2
          },
          {
            label: "Page Views",
            data: [],
            borderColor: "#0F2044",
            backgroundColor: "rgba(15, 32, 68, 0.05)",
            fill: true,
            tension: 0.3,
            pointRadius: 2,
            pointHoverRadius: 5,
            borderWidth: 2
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        interaction: { intersect: false, mode: "index" },
        plugins: {
          legend: {
            position: "top",
            labels: { font: { family: "Inter", size: 12 }, usePointStyle: true, padding: 16 }
          },
          tooltip: {
            backgroundColor: "#0F2044",
            titleFont: { family: "Inter", size: 12 },
            bodyFont: { family: "Inter", size: 12 },
            padding: 10,
            cornerRadius: 6
          }
        },
        scales: {
          x: {
            grid: { display: false },
            ticks: { font: { family: "Inter", size: 11 }, color: "#9CA3AF", maxRotation: 0 }
          },
          y: {
            beginAtZero: true,
            grid: { color: "#F3F4F6" },
            ticks: { font: { family: "Inter", size: 11 }, color: "#9CA3AF", precision: 0 }
          }
        }
      }
    })
  }

  showRange(event) {
    const days = parseInt(event.currentTarget.dataset.days)
    const daysValue = parseInt(event.currentTarget.dataset.days)

    this.tabTargets.forEach(btn => btn.classList.remove("active-tab"))
    event.currentTarget.classList.add("active-tab")

    this.filterByRange(daysValue)
  }

  filterByRange(days) {
    const now = new Date()
    const cutoff = new Date(now)

    if (days === 1) {
      cutoff.setHours(0, 0, 0, 0)
    } else {
      cutoff.setDate(cutoff.getDate() - days)
      cutoff.setHours(0, 0, 0, 0)
    }

    const labels = []
    const visits = []
    const pageViews = []

    Object.keys(this.allVisits).sort().forEach(dateStr => {
      const d = new Date(dateStr + "T00:00:00")
      if (d >= cutoff) {
        const label = d.toLocaleDateString("en-US", { month: "short", day: "numeric" })
        labels.push(label)
        visits.push(this.allVisits[dateStr] || 0)
        pageViews.push(this.allPageViews[dateStr] || 0)
      }
    })

    this.chart.data.labels = labels
    this.chart.data.datasets[0].data = visits
    this.chart.data.datasets[1].data = pageViews
    this.chart.update()
  }
}
