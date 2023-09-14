use candid::{CandidType, Deserialize};
use std::{cmp::Reverse, collections::BinaryHeap};

pub type OrderId = u64;

#[derive(PartialEq, Eq, Clone, CandidType, Deserialize)]
pub enum Side {
    Buy,
    Sell,
}

pub type Price = u64;
pub type Quantity = u64;

#[derive(PartialEq, Eq, Clone, CandidType, Deserialize)]
pub struct Order {
    pub id: OrderId,
    pub side: Side,
    pub price: Price,
    pub quantity: Quantity,
}

#[derive(CandidType, Deserialize)]
pub struct Match {
    pub bid_id: OrderId,
    pub ask_id: OrderId,
    pub price: Price,
    pub quantity: Quantity,
}

impl Order {
    pub fn try_match(&self, other: &Self) -> Option<Match> {
        if self.quantity > 0
            && other.quantity > 0
            && self.side != other.side
            && ((self.side == Side::Buy && self.price >= other.price)
                || (self.side == Side::Sell && self.price <= other.price))
        {
            let quantity = std::cmp::min(self.quantity, other.quantity);
            let (bid_id, ask_id) = if self.side == Side::Buy {
                (self.id, other.id)
            } else {
                (other.id, self.id)
            };
            Some(Match {
                bid_id,
                ask_id,
                // If there's a match
                price: self.price,
                quantity,
            })
        } else {
            None
        }
    }
}

impl PartialOrd for Order {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

impl Ord for Order {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        self.price.cmp(&other.price).then(self.id.cmp(&other.id))
    }
}

pub struct OrderBook {
    bids: BinaryHeap<Order>,
    asks: BinaryHeap<Reverse<Order>>,
}

/// We'd like to treat bids and asks uniformely, but they're binary heaps
/// of different types. Abstract over this difference with a trait.
trait OrderQueue {
    fn pop_best(&mut self) -> Option<Order>;
    fn push(&mut self, order: Order);
    fn peek_best(&self) -> Option<&Order>;
}

impl OrderQueue for BinaryHeap<Order> {
    fn pop_best(&mut self) -> Option<Order> {
        self.pop()
    }

    fn push(&mut self, order: Order) {
        self.push(order);
    }

    fn peek_best(&self) -> Option<&Order> {
        self.peek()
    }
}

impl OrderQueue for BinaryHeap<Reverse<Order>> {
    fn pop_best(&mut self) -> Option<Order> {
        self.pop().map(|Reverse(order)| order)
    }

    fn push(&mut self, order: Order) {
        self.push(Reverse(order));
    }

    fn peek_best(&self) -> Option<&Order> {
        self.peek().map(|Reverse(order)| order)
    }
}

impl OrderBook {
    pub fn new() -> Self {
        Self {
            bids: BinaryHeap::new(),
            asks: BinaryHeap::new(),
        }
    }

    /// Add an order to the order book; if it crosses with existing orders, return the match(es).
    /// Fill as much of the order as possible, and just keep the remainder on the order book.
    pub fn add_order(&mut self, order: Order) -> Vec<Match> {
        assert!(order.quantity > 0);
        assert!(order.price > 0);
        match order.side {
            Side::Buy => {
                let (matches, opt_remaining_bid) = process_order(order, &mut self.asks);
                if let Some(remaining_bid) = opt_remaining_bid {
                    self.bids.push(remaining_bid);
                }
                matches
            }
            Side::Sell => {
                let (matches, opt_remaining_ask) = process_order(order, &mut self.bids);
                if let Some(remaining_ask) = opt_remaining_ask {
                    self.asks.push(Reverse(remaining_ask));
                }
                matches
            }
        }
    }

    pub fn list_bids(&self) -> Vec<Order> {
        self.bids.iter().cloned().collect()
    }

    pub fn list_asks(&self) -> Vec<Order> {
        self.asks
            .iter()
            .cloned()
            .map(|Reverse(order)| order)
            .collect()
    }
}

fn process_order<T: OrderQueue>(
    mut order: Order,
    other_side: &mut T,
) -> (Vec<Match>, Option<Order>) {
    let mut matches = Vec::new();
    while let Some(m) = other_side
        .peek_best()
        .and_then(|other| order.try_match(other))
    {
        order.quantity -= m.quantity;
        let mut other = other_side.pop_best().unwrap();
        other.quantity -= m.quantity;
        if other.quantity > 0 {
            other_side.push(other);
        }
        matches.push(m);
    }
    (
        matches,
        if order.quantity > 0 {
            Some(order)
        } else {
            None
        },
    )
}

pub mod canister;
