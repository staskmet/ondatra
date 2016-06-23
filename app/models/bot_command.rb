require 'telegram/bot'

module BotCommand
  class Base
    attr_reader :user, :message, :api

    def initialize(user, message)
      @user = user
      @message = message
      token = Rails.application.secrets.bot_token
      @api = ::Telegram::Bot::Api.new(token)
    end

    def should_start?
      raise NotImplementedError
    end

    def start
      raise NotImplementedError
    end

    protected

    def send_message(text, options={})
      @api.call('sendMessage', chat_id: @user.telegram_id, text: text)
    end

    def text
      @message[:message][:text]
    end

    def from
      @message[:message][:from]
    end
  end

  class Start < Base
    def should_start?
      # TODO: понять, что значит запись text =~ /\A\/start/
      text == '/start'
    end

    def start
      send_message('Hello! This is start command!')
      # user.reset_next_bot_command
      # user.set_next_bot_command('BotCommand::Born')
    end
  end

  class Undefined < Base
    def start
      send_message('Unknown command. Type /start or the appropriate command.')
    end
  end
end
