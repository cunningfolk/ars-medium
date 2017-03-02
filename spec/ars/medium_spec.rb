require "spec_helper"

module Ars
  RSpec.describe Medium do
    it "has a version number" do
      expect(Ars::Medium::VERSION).not_to be_nil
    end

    describe 'configuration()' do
      subject { described_class.configuration }

      it { is_expected.to be_a(Medium::Configuration)}
    end
  end
end
