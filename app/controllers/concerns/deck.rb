module Deck

  #<%= image_tag ('cards/10_of_clubs') %>
  # creates an array of 52 cards

  private


  # creates the initial deck and returns two sets of strings
  def create_values_and_split
    arr = []
    0.upto(51).each{|num| arr.push(num)}
    arr.shuffle!

    user_1_deck = []
    user_2_deck = []

    arr.each_with_index do |num,index|
      if index % 2 == 0
        user_1_deck.push(num)
      else
        user_2_deck.push(num)
      end
    end

    user_1_deck = user_1_deck.join(',')
    user_2_deck = user_2_deck.join(',')

    return user_1_deck,user_2_deck

  end

  def card_image_name (input) # 23
    suits = ['clubs', 'diamonds', 'hearts', 'spades']
    values = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'jack', 'queen', 'king', 'ace']
    deck = []

    values.each do |value|
      suits.each do |suit|
        card_hash = { name: "#{value}", suit: suit }
        deck.push(card_hash)
      end
    end

    output = deck[input]
    output = "#{output[:name]}_of_#{output[:suit]}"

    return output

  end # => 7_of_spades


  def compare_cards(a,b)
    if a[0][:worth] > b[0][:worth]
      # a wins
    elsif a[0][:worth] < b[0][:worth]
      # b wins
    else
      # war
    end
  end


  def card_image(card_hash)
    "cards/#{card_hash[0][:name]}_of_#{card_hash[0][:suit]}"
  end


end
