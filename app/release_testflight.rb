#!/usr/bin/env ruby
require "runbook"

runbook = Runbook.book "Release Testflight" do
  description <<-DESC
This is a runbook for releasing the iOS version of the app
to TestFlight.
  DESC

  section "Update code and dependencies" do
    step "Run 'git pull'"
    step "Run 'yarn install'"
    step "Run 'bundle install'"
    step "Run 'yarn generate:all'"
    step "Run 'cd ios'"
    step "Run 'fastlane beta_testflight'" do
      ask "What's the newly released version? (e.g. 0.1(28))", into: :ios_release
    end
    step "Share the new release on the #io-dev Slack channel" do
      ruby_command {
        note "Nuova release iOS `#{@ios_release}` su Testflight"
      }
    end
  end
end

if __FILE__ == $0
  Runbook::Runner.new(runbook).run
else
  runbook
end
