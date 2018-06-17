require 'spec_helper'
RSpec.describe HelloC do
  it "has a version number" do
    expect(HelloC::VERSION).not_to be nil
  end

  describe '#len' do
    it do
      expect(HelloC.len('abc')).to eq 3
    end
  end
end
