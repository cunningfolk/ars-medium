require 'activemodel'

class ActiveModelTester
  include ActiveModel::Model

  attr_accessor :attr1, :attr2
end

class ActiveModelMedium
  include Ars::Medium
end

RSpec.describe 'Ars-Medium Useage' do
  describe 'ActiveModel' do
    
  end
end
