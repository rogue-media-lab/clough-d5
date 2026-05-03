class Priority < ApplicationRecord
  belongs_to :linked_issue, class_name: "Issue", optional: true

  scope :active, -> { where(active: true) }
  scope :ordered, -> { order(position: :asc) }

  validates :title, presence: true
  validates :position, numericality: { greater_than: 0, only_integer: true }, allow_nil: true

  ICONS = {
    "money"       => "Dollar / Costs",
    "briefcase"   => "Jobs / Work",
    "heart"       => "Healthcare / Care",
    "grad-cap"    => "Education / Skills",
    "flag"        => "Government / Values",
    "check-circle"=> "Accountability",
    "building"    => "Infrastructure / Business",
    "clock"       => "Time / Term Limits",
    "shield"      => "Safety / Protection"
  }.freeze

  def icon_label
    ICONS[icon] || icon
  end
end
