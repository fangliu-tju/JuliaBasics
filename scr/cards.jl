"""
This file contains a code example related to

Julia 程序设计基础
by Fang Liu
https://github.com/fangliu-tju/JuliaBasics/tree/master/scr/cards.jl

Copyright 2020 Fang Liu

License: http://creativecommons.org/licenses/by/4.0/
"""

using Random

const suit_names = ["♧", "♢", "♡", "♤"]
const rank_names = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
const all_labels = ["straightflush", "fourkind", "fullhouse", "flush", "straight", "threekind", "twopair", "pair", "highcard"]

abstract type CardSet end

"""
Rperesents a standard playing card.

# Arguments
- `suit`: integer 1-4
- `rank`: integer 1-13
"""
struct Card
    suit :: Int64
    rank :: Int64
    function Card(suit::Int64=1, rank::Int64=2)
        @assert 1 <= suit <= 4 "suit is  not between 1 and 4"
        @assert 1 <= rank <= 13 "rank is not between 1 and 13"
        new(suit, rank)
    end
end

function Base.show(io::IO, card::Card)
    print(io, suit_names[card.suit], rank_names[card.rank])
end

function Base.isless(c1::Card, c2::Card)
    (c1.suit, c1.rank) < (c2.suit, c2.rank)
end

"""
Represents a deck of cards.

# Arguments
- `cards`: array of Card objects.
"""
struct Deck <: CardSet
    cards :: Array{Card, 1}
end

function Deck()
    deck = Deck(Card[])
    for suit in 1:4
        for rank in 1:13
            push!(deck.cards, Card(suit, rank))
        end
    end
    deck
end


struct Hand <: CardSet
    cards :: Array{Card, 1}
    player :: String
end

function Hand(player::String="")
    Hand(Card[], player)
end

function Base.show(io::IO, cs::CardSet)
    for card in cs.cards
        print(io, card, " ")
    end
end

function Base.pop!(cs::CardSet)
    pop!(cs.cards)
end

function Base.push!(cs::CardSet, card::Card)
    push!(cs.cards, card)
    nothing
end

function Random.shuffle!(deck::Deck)
    shuffle!(deck.cards)
    nothing
end

function Base.sort!(cs::CardSet)
    sort!(cs.cards)
    nothing
end

function move!(cs1::CardSet, cs2::CardSet, n::Int)
    @assert 1 ≤ n ≤ length(cs1.cards)
    for i in 1:n
        card = pop!(cs1)
        push!(cs2, card)
    end
    nothing
end

function histograms(hand::Hand)
    suits = Dict()
    ranks = Dict()
    for c in hand.cards
        suits[c.suit] = get(suits, c.suit, 0) + 1
        ranks[c.rank] = get(ranks, c.rank, 0) + 1
    end
    rarras = sort(collect(values(ranks)), rev=true)
    (suits, ranks, rarras)
end

function histograms(sarr::Array{String, 1})
    d = Dict()
    for s in sarr
        d[s] = get(d, s, 0) + 1
    end
    d
end

function has_highcard(hand::Hand)
    true
end

function check_arras(hand::Hand, t...)
    _, _, rfs = histograms(hand)
    for (need, have) in zip(t, rfs)
        if need > have
            return false
        end
    end
    true
end

function has_pair(hand::Hand)
    check_arras(hand, 2)
end

function has_twopair(hand::Hand)
    check_arras(hand, 2, 2)
end

function has_threekind(hand::Hand)
    check_arras(hand, 3)
end

function has_fourkind(hand::Hand)
    check_arras(hand, 4)
end

function has_fullhouse(hand::Hand)
    check_arras(hand, 3, 2)
end

function has_flush(hand::Hand)
    suits, _, _ = histograms(hand)
    for val in values(suits)
        val >= 5 && return true
    end
    false
end

function has_straight(hand::Hand)
    _, ranks, _ = histograms(hand)
    haskey(ranks, 1) && (ranks[14] = ranks[1])
    count = 0
    for i in 1:14
        if i ∈ keys(ranks)
            count += 1
            count == 5 && return true
        else
            count = 0
        end
    end
    false
end

function suits_dict(hand::Hand)
    suits = Dict()
    for c in hand.cards
        suits[c.suit] = push!(get(suits, c.suit, []), c.rank)
    end
    suits
end

function has_straightflush(hand::Hand)
    suits = suits_dict(hand)
    for val in values(suits)
        length(val) < 5 && continue
        1 ∈ val && push!(val, 14)
        count = 0
        for i in 1:14
            if i ∈ val
                count += 1
                count == 5 && return true
            else
                count = 0
            end
        end
    end
    false
end

function classify(hand::Hand)
    for label in all_labels
        fns = Symbol("has_" * label)
        ex = Expr(:call, fns, hand)
        eval(ex) && return label
    end
end

function deal_hands(num_cards=5, num_hands=10)
    hands = String[]
    deck = Deck()
    shuffle!(deck)
    for i in 1:num_hands
        hand = Hand()
        move!(deck, hand, num_cards)
        push!(hands, classify(hand))
    end
    hands
end

function main(n=10000)
    freq = Dict()
    print("Computing")
    for i in 1:n
        i % 1000 == 0 && print("...")

        hands = deal_hands(7, 7)
        dlabels = histograms(hands)
        for key in keys(dlabels)
            freq[key] = get(freq, key, 0) + dlabels[key]
        end
    end
    print("\n")
    total = 7 * n
    println(total, " hands dealt:")
    for (label, f) in freq
        p = trunc(Int, total / f)
        println("$label happens one time in $p")
    end
end


main()
