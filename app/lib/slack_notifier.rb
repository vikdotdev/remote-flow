class SlackNotifier
  def SlackNotifier.ping(message)
    if SLACK_CONFIG[:enabled]
      notifier = Slack::Notifier.new(
        SLACK_CONFIG[:token],
        channel: SLACK_CONFIG[:channel],
        username: SLACK_CONFIG[:username]
      )

      notifier.ping message
    end
  end
end
