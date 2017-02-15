require 'ars/medium'
require 'json'

class TestMedium < Ars::Medium::Model
  attributes :id, :my_attr
end

TestModel = Struct.new(:id, :my_attr) do
  def to_json
    to_h.to_json
  end
end

module Ars::Medium
  RSpec.describe TestMethods do
  end

  RSpec.describe TestMethods::RackChanneler do
    include_context "Ars::Medium API Stubs", TestMedium

    describe '.find(:id)' do
      let(:model) { TestModel.new(123, :thing!) }
      before { allow(rack_handle).to receive(:body).and_return([model.to_json]) }
      let(:medium) { TestMedium.find(123) }
      subject { medium }

      it { is_expected.to have_attributes id: 123 }
      it { is_expected.to have_attributes my_attr: 'thing!' }
    end
  end
end
