Rails.application.config.SLACK_CONFIG = YAML.load_file('config/slack.yml')[Rails.env].symbolize_keys

