class Event < ApplicationRecord
  enum :status, { upcoming: 0, past: 1 }
end
