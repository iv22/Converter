class ConverterValidator < ActiveModel::Validator
  def validate(record)
    if (record.amount.to_i) < 100
      record.errors.add :base, "Amount is too small :)"
    end
  end
end