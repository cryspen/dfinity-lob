use ic_cdk_macros::{export_candid, query, update};
use std::cell::RefCell;

use lob_backend::{Ask, Bid, Match, Order, OrderBook};

thread_local! {
    static ORDER_BOOK: RefCell<Option<OrderBook>> = RefCell::default();
}

#[update]
pub fn add_order(order: Order) -> Vec<Match> {
    ORDER_BOOK.with(|ob| {
        ob.borrow_mut()
            .as_mut()
            .expect("Order book not initialized")
            .add_order(order)
    })
}

#[query]
pub fn get_book() -> (Vec<Bid>, Vec<Ask>) {
    ORDER_BOOK.with(|ob| {
        let ob = ob.borrow();
        (
            ob.as_ref().expect("Order book not initialized").list_bids(),
            ob.as_ref().expect("Order book not initialized").list_asks(),
        )
    })
}

fn main() {}

export_candid!();
