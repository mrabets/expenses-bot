require 'telegram/bot'
require './requests.rb'
require 'pry'

token = '5305087563:AAG3xDx0bJzYwXS-K4yDdZ1pOKHVzAimxzM'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      expenses = get_all_expenses
      bot.api.send_message(chat_id: message.chat.id, text: "#{expenses}", parse_mode: "HTML")
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    end
  end
end
