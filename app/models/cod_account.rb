class CodAccount < ApplicationRecord
  validates :amount_received, presence: true
  validate :owed_and_received
  validate :check

  def owed_and_received
    if !errors.any?
      if !$value || $value != amount_received
        $value = amount_received
        if amount_received != amount_owed
          errors.add(:amount_received, "is not equal to amount owed. Press 'Update' again to continue.")
        end
      end
    end
  end

  def check
    if !errors.any?
      if received_as == 'Check' && !check_numb.present?
          errors.add(:check_numb, "is required when check is received.")
      end
    end
  end

end
