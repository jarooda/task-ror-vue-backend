class Task < ApplicationRecord
  belongs_to :user

  validates :due_date, presence: true
end
