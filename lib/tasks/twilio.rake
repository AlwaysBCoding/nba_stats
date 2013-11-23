namespace :data do
  desc "scrapes REALGM transaction list to find NBA Transactions, databases and sends an SMS to my phone if there is a new transaction"
  task :send_nba_transactions => :environment do
    puts "STARTED RAKE TASK: SEND NBA TRANSACTIONS"
    require "open-uri"

    client = Twilio::REST::Client.new TWILIO_ACCOUNT_ID, TWILIO_AUTH_TOKEN
    doc = Nokogiri::HTML(open("http://basketball.realgm.com/nba/transactions/league"))

    daily_transaction_list = doc.css("div.transByMonth:first ul:nth-of-type(1) > li")

    new_transactions = daily_transaction_list.select do |transaction|
      !NbaTransaction.where(description: transaction.text.strip).present?
    end

    new_transactions.each do |transaction|
      NbaTransaction.transaction do
        nba_transaction = NbaTransaction.create! transaction_date: -> { Date.today }.call, description: transaction.text.strip
        puts "CREATED TRANSACTION #{nba_transaction.id}: #{nba_transaction.description}"

        client.account.messages.create({
          from: TWILIO_PHONE_NUMBER,
          to: PERSONAL_PHONE_NUMBER,
          body: nba_transaction.description
        })

        puts "SENT TEXT MESSAGE FOR TRANSACTION: #{nba_transaction.id}"
      end
    end

    puts "NO NEW TRANSACTIONS" if !new_transactions.present?

    puts "SHUTTING DOWN RAKE TASK: SEND NBA TRANSACTIONS..."
  end
end
