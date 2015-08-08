class Person < ActiveRecord::Base
  validates :height, presence: true, numericality: { :greater_than_or_equal_to => 0 }
  validates :weight, presence: true, numericality: { :greater_than_or_equal_to => 0 }
  before_update do 
    self.gender.to_i
  end
  include PersonConcerns
  
  def run_predictor
    include_gathered_data
    create_prediction
    set_prediction
  end
  
end
