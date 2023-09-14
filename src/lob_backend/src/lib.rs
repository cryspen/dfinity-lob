use candid::{CandidType, Deserialize};
use std::collections::BinaryHeap;

pub type OrderId = u64;

#[derive(CandidType, Deserialize)]
pub enum Side {
    Buy,
    Sell,
}

pub type Price = u64;
pub type Quantity = u64;

#[derive(PartialEq, Eq, Clone, CandidType, Deserialize)]
pub struct OrderParameters {
    price: Price,
    quantity: Quantity,
}

#[derive(CandidType, Deserialize)]
pub struct Order {
    pub id: OrderId,
    pub side: Side,
    pub parameters: OrderParameters,
}
#[derive(PartialEq, Eq, Clone, CandidType, Deserialize)]
pub struct Bid {
    pub id: OrderId,
    pub parameters: OrderParameters,
}

impl PartialOrd for Bid {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

impl Ord for Bid {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        self.parameters
            .price
            .cmp(&other.parameters.price)
            .then(self.id.cmp(&other.id))
    }
}

#[derive(PartialEq, Eq, Clone, CandidType, Deserialize)]
pub struct Ask {
    id: OrderId,
    parameters: OrderParameters,
}

impl PartialOrd for Ask {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

impl Ord for Ask {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        self.parameters
            .price
            .cmp(&other.parameters.price)
            .reverse()
            .then(self.id.cmp(&other.id))
    }
}

pub struct OrderBook {
    bids: BinaryHeap<Bid>,
    asks: BinaryHeap<Ask>,
}

#[derive(CandidType, Deserialize)]
pub struct Match {
    pub bid_id: OrderId,
    pub ask_id: OrderId,
    pub price: Price,
    pub quantity: Quantity,
}

impl OrderBook {
    pub fn new() -> Self {
        Self {
            bids: BinaryHeap::new(),
            asks: BinaryHeap::new(),
        }
    }

    /// Add an order to the order book; if it crosses with existing orders, return the match(es).
    /// Fulfill as much of the order as possible, and just keep the remainder on the order book.
    pub fn add_order(&mut self, order: Order) -> Vec<Match> {
        assert!(order.parameters.quantity > 0);
        assert!(order.parameters.price > 0);
        let mut matches = Vec::new();
        let mut unfulfilled = order.parameters.quantity;
        match order.side {
            Side::Buy => {
                while unfulfilled > 0
                    && self
                        .best_ask()
                        .map(|ask| ask.parameters.price <= unfulfilled)
                        .unwrap_or(false)
                {
                    let mut ask = self.asks.pop().unwrap();
                    let quantity = std::cmp::min(unfulfilled, ask.parameters.quantity);
                    matches.push(Match {
                        bid_id: order.id,
                        ask_id: ask.id,
                        price: ask.parameters.price,
                        quantity,
                    });
                    unfulfilled -= quantity;
                    ask.parameters.quantity -= quantity;
                    if ask.parameters.quantity > 0 {
                        self.asks.push(ask);
                    }
                }
                if unfulfilled > 0 {
                    self.bids.push(Bid {
                        id: order.id,
                        parameters: OrderParameters {
                            price: order.parameters.price,
                            quantity: unfulfilled,
                        },
                    });
                }
            }
            Side::Sell => {
                while unfulfilled > 0
                    && self
                        .best_bid()
                        .map(|bid| bid.parameters.price >= unfulfilled)
                        .unwrap_or(false)
                {
                    let mut bid = self.bids.pop().unwrap();
                    let quantity = std::cmp::min(unfulfilled, bid.parameters.quantity);
                    matches.push(Match {
                        bid_id: bid.id,
                        ask_id: order.id,
                        price: bid.parameters.price,
                        quantity,
                    });
                    unfulfilled -= quantity;
                    bid.parameters.quantity -= quantity;
                    if bid.parameters.quantity > 0 {
                        self.bids.push(bid);
                    }
                }
                if unfulfilled > 0 {
                    self.asks.push(Ask {
                        id: order.id,
                        parameters: OrderParameters {
                            price: order.parameters.price,
                            quantity: unfulfilled,
                        },
                    });
                }
            }
        }

        matches
    }

    fn best_bid(&self) -> Option<&Bid> {
        self.bids.peek()
    }

    fn best_ask(&self) -> Option<&Ask> {
        self.asks.peek()
    }

    pub fn list_bids(&self) -> Vec<Bid> {
        self.bids.iter().cloned().collect()
    }

    pub fn list_asks(&self) -> Vec<Ask> {
        self.asks.iter().cloned().collect()
    }
}
