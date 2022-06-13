require "faraday"
require 'pry'
require 'json'
require 'terminal-table'
require "csv"

HOST = "http://localhost:3001"

def get_all_expenses
  response = Faraday.get("#{HOST}/expenses")
  
  expense_beauty(JSON.parse(response.body)) if response.status == 200
end

def expense_beauty(expenses)
  rows = []
  expenses.each do |expense|
    expense.transform_keys!(&:to_sym)[:id]
    rows << ["#{Date.parse(expense[:date])}", "#{expense[:cost]}", "#{expense[:category]}"]
  end

  "<pre>#{table(rows).to_s}</pre>"
end

def table(rows)
  Terminal::Table.new :headings => ['DATE', 'COST', 'CATEGORY'], :rows => rows
end