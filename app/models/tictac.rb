class Tictac < ApplicationRecord
  include AASM
  #relationship
  belongs_to :user
  belongs_to :task , required: false

  #aasm
  aasm column: 'status' do
    state :pending, initial: true
    state :processing, :cancelled, :finished
  
    event :start do
      transitions from: :pending, to: :processing
      after_transaction :status_start
    end
  
    event :cancel do
      transitions from: :processing, to: :cancelled
      after_transaction :status_cancel
    end

    event :finish do
      transitions from: :processing, to: :finished
      after_transaction :status_finish
    end

  end

  private
  
  def status_start
    update(status: 'processing', start_at: Time.now)
  end
  def status_cancel
    update(status: 'cancelled', end_at: Time.now)
  end
  def status_finish
    update(status: 'finished', end_at: Time.now)
  end

end
