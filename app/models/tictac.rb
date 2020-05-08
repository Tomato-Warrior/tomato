class Tictac < ApplicationRecord
  include AASM
  #relationship
  belongs_to :user
  belongs_to :task , required: false

  #aasm
  aasm column: 'status' do
    state :pending, initial: true
    state :failed, :finished
  
    event :processing do
      transitions from: :pending, to: :finished
    end
  
    event :processing do
      transitions from: :pending, to: :failed
    end
  end
end
