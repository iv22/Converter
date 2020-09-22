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
class Rate < ApplicationRecord

  WEB_SOURCE = 'https://www.nbrb.by/api/exrates/rates?periodicity=0'
  
  def self.fill_data
    data_clazz = Converter::DataFactory.for('web')       
    data = data_clazz.get_data(WEB_SOURCE)
    data.each do |cur, attr|
      Rate.create(
        abbreviation: cur, 
        name: attr['Cur_Name'],
        rate: attr['Cur_OfficialRate'],
        scale: attr['Cur_Scale']        
      )
    end
  end
end
