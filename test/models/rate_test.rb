# == Schema Information
#
# Table name: rates
#
#  id           :integer          not null, primary key
#  abbreviation :string
#  name         :string
#  rate         :float
#  scale        :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_rates_on_name  (name) UNIQUE
#
require 'test_helper'

class RateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
