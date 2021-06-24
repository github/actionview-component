# frozen_string_literal: true

require "action_mailer"

class TestMailer < ActionMailer::Base
  def test_email
    mail(
      from: "no-reply@example.com",
      to: "test@example.com",
      subject: "Testing ViewComponent in ActionMailer",
    )
  end
end
