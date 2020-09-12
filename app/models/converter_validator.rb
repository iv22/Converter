class ConverterValidator < ActiveModel::Validator
  def validate(record)
    if (record.amount.to_i) < 100
      record.errors.add :amount, :is_too_small
    end
  end
end