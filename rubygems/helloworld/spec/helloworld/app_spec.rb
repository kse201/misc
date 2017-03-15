require 'spec_helper'

module Helloworld
  describe App do
    describe '#start' do
      let(:app) { App.new }
      it "puts 'Hello World' in stdout" do
        expect { app.start }.to output("Hello World\n").to_stdout
      end

      it 'puts nothing in stderr' do
        expect { app.start }.to output('').to_stderr
      end
    end
  end
end
