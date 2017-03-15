# coding: utf-8

Given(/^アプリが動作していない$/) do
end

When(/^アプリが動作開始する$/) do
  @app = Helloworld::App.new
  @app.start
end

Then(/^"([^"]*)"が出力される$/) do |str|
  expect { @app.start }.to output("#{str}\n").to_stdout
end
