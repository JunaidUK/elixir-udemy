defmodule Cards do
  @moduledoc """
    This module provides methods for creating and handling a deck of cards
  """
  # def hello do
  #   "hi there!"
  # end

  @doc """
    Returns a list of strings representing a deck of playing cards
  """
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
  @doc """
    Determines whether a deck contains a given card

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
      
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicated how many cards should be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck,1)
      iex> hand
      ["Ace of Spades"]

  """
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
    #Try to use case statements as much as possible. AVOID IFs. This is an example of error handling
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end
  end

    def create_hand(hand_size) do
      #This is what it would look like without pipe operator
      # deck = Cards.create_deck
      # deck = Cards.shuffle(deck)
      # hand = Cards.deal(deck, hand_size)

      #Using pipe operator!!
      Cards.create_deck
      |> Cards.shuffle
      |> Cards.deal(hand_size)
    end

end
