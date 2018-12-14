defmodule Cards do

  # def hello do
  #   "hi there!"
  # end

  # For the purposes of tutorial follow-along, we will use only 5 cards
  def create_deck do
    values = ["Ace", "Two", "Three","Four","Five", "Six",
    "Seven", "Eight", "Nine", "Ten", "Jack","Queen", "King"]
    suits = ["Spades","Clubs","Hearts", "Diamonds"]

  # List comprehension: for every element in suits, do this thing (in this case print a suit)
  # THIS IS ESSENTIALLY A MAP. CREATES A NEW ARRAY

  #This is a bad way of iterating over two enumerables
  # cards = for value <- values do
  #     for suit <- suits do
  #       "#{value} of #{suit}"
  #     end
  #   end
  # Goes through each array returned by the above map, and puts them all into one array (flattens it)
  # List.flatten(cards)

  #PREFERRED WAY
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end

  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck,hand_size) do
    Enum.split(deck, hand_size)
    # This enum returns a Tuple {myHand, theRest}
    # Ruby equivalent is {hand: [], deck: []}
    # To access specific parts of Tuple, pattern match. That looks like: {hand, rest_of_deck} = Cards.deal(5, deck). You can then call hand, and rest_of_deck as variables
  end

  def save(deck, filename) do
    #takes deck argument, and converts it to something that can be written to file system
    binary = :erlang.term_to_binary(deck)
    File.write(filename,binary)
  end

  def load(filename) do
    {status, binary} = File.read(filename)

    #Try to use case statements as much as possible. AVOID IFs. This is an example of error handling
    case status do
      :ok -> :erlang.binary_to_term(binary)
      :error -> "That file does not exist"
    end
  end

end
