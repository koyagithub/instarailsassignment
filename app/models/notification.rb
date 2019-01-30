class Notification < ApplicationRecord
    belongs_to :comment
    validates :n_comment, presence: true
    default_scope -> { order(created_at: :desc) }
end
