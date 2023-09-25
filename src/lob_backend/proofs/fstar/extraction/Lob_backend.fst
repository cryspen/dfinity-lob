module Lob_backend
#set-options "--fuel 0 --ifuel 1 --z3rlimit 15"
open Core

let t_OrderId = u64

type t_Side =
  | Side_Buy : t_Side
  | Side_Sell : t_Side

let impl: Candid.Types.t_CandidType t_Side =
  {
    _ty
    =
    (fun  ->
        Core.Convert.Into.into (Candid.Types.Internal.TypeInner_Variant
            (Alloc.Slice.into_vec_under_impl (Rust_primitives.unsize (Rust_primitives.Hax.box_new (let
                          list =
                            [
                              {
                                Candid.Types.Internal.Field.f_id
                                =
                                Core.Convert.Into.into (Candid.Types.Internal.Label_Named
                                    (Alloc.Borrow.ToOwned.to_owned "Buy" <: _))
                                <:
                                Alloc.Rc.t_Rc Candid.Types.Internal.t_Label;
                                Candid.Types.Internal.Field.f_ty
                                =
                                Core.Convert.Into.into Candid.Types.Internal.TypeInner_Null
                                <:
                                Candid.Types.Internal.t_Type
                              };
                              {
                                Candid.Types.Internal.Field.f_id
                                =
                                Core.Convert.Into.into (Candid.Types.Internal.Label_Named
                                    (Alloc.Borrow.ToOwned.to_owned "Sell" <: _))
                                <:
                                Alloc.Rc.t_Rc Candid.Types.Internal.t_Label;
                                Candid.Types.Internal.Field.f_ty
                                =
                                Core.Convert.Into.into Candid.Types.Internal.TypeInner_Null
                                <:
                                Candid.Types.Internal.t_Type
                              }
                            ]
                          in
                          FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 2);
                          Rust_primitives.Hax.array_of_list list)
                      <:
                      Alloc.Boxed.t_Box (array Candid.Types.Internal.t_Field 2sz)
                        Alloc.Alloc.t_Global)
                  <:
                  Alloc.Boxed.t_Box (slice Candid.Types.Internal.t_Field) Alloc.Alloc.t_Global)
              <:
              Alloc.Vec.t_Vec Candid.Types.Internal.t_Field Alloc.Alloc.t_Global)));
    id = (fun  -> Candid.Types.Internal.of_under_impl);
    idl_serialize
    =
    fun (self: t_Side) (v___serializer: v___s) ->
      Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* _:Prims.unit =
            match self with
            | Side_Buy  ->
              let* ser:_ =
                match
                  Core.Ops.Try_trait.Try.branch (Candid.Types.Serializer.serialize_variant v___serializer
                        0uL
                      <:
                      Core.Result.t_Result _ _)
                with
                | Core.Ops.Control_flow.ControlFlow_Break residual ->
                  let* hoist1:Rust_primitives.Hax.t_Never =
                    Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                          residual
                        <:
                        Core.Result.t_Result Prims.unit _)
                  in
                  Core.Ops.Control_flow.ControlFlow_Continue
                  (Rust_primitives.Hax.never_to_any hoist1)
                | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
                  Core.Ops.Control_flow.ControlFlow_Continue v_val
              in
              Core.Ops.Control_flow.ControlFlow_Continue ()
            | Side_Sell  ->
              let* ser:_ =
                match
                  Core.Ops.Try_trait.Try.branch (Candid.Types.Serializer.serialize_variant v___serializer
                        1uL
                      <:
                      Core.Result.t_Result _ _)
                with
                | Core.Ops.Control_flow.ControlFlow_Break residual ->
                  let* hoist2:Rust_primitives.Hax.t_Never =
                    Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                          residual
                        <:
                        Core.Result.t_Result Prims.unit _)
                  in
                  Core.Ops.Control_flow.ControlFlow_Continue
                  (Rust_primitives.Hax.never_to_any hoist2)
                | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
                  Core.Ops.Control_flow.ControlFlow_Continue v_val
              in
              Core.Ops.Control_flow.ControlFlow_Continue ()
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Core.Result.Result_Ok ()))
  }

let v___: Prims.unit = ()

let t_Price = u64

let t_Quantity = u64

type t_Order = {
  f_id:u64;
  f_side:t_Side;
  f_price:u64;
  f_quantity:u64
}

let impl: Candid.Types.t_CandidType t_Order =
  {
    _ty
    =
    (fun  ->
        Core.Convert.Into.into (Candid.Types.Internal.TypeInner_Record
            (Alloc.Slice.into_vec_under_impl (Rust_primitives.unsize (Rust_primitives.Hax.box_new (let
                          list =
                            [
                              {
                                Candid.Types.Internal.Field.f_id
                                =
                                Core.Convert.Into.into (Candid.Types.Internal.Label_Named
                                    (Alloc.String.ToString.to_string "id" <: Alloc.String.t_String))
                                <:
                                Alloc.Rc.t_Rc Candid.Types.Internal.t_Label;
                                Candid.Types.Internal.Field.f_ty
                                =
                                Candid.Types.CandidType.ty <: Candid.Types.Internal.t_Type
                              };
                              {
                                Candid.Types.Internal.Field.f_id
                                =
                                Core.Convert.Into.into (Candid.Types.Internal.Label_Named
                                    (Alloc.String.ToString.to_string "side" <: Alloc.String.t_String
                                    ))
                                <:
                                Alloc.Rc.t_Rc Candid.Types.Internal.t_Label;
                                Candid.Types.Internal.Field.f_ty
                                =
                                Candid.Types.CandidType.ty <: Candid.Types.Internal.t_Type
                              };
                              {
                                Candid.Types.Internal.Field.f_id
                                =
                                Core.Convert.Into.into (Candid.Types.Internal.Label_Named
                                    (Alloc.String.ToString.to_string "quantity"
                                      <:
                                      Alloc.String.t_String))
                                <:
                                Alloc.Rc.t_Rc Candid.Types.Internal.t_Label;
                                Candid.Types.Internal.Field.f_ty
                                =
                                Candid.Types.CandidType.ty <: Candid.Types.Internal.t_Type
                              };
                              {
                                Candid.Types.Internal.Field.f_id
                                =
                                Core.Convert.Into.into (Candid.Types.Internal.Label_Named
                                    (Alloc.String.ToString.to_string "price"
                                      <:
                                      Alloc.String.t_String))
                                <:
                                Alloc.Rc.t_Rc Candid.Types.Internal.t_Label;
                                Candid.Types.Internal.Field.f_ty
                                =
                                Candid.Types.CandidType.ty <: Candid.Types.Internal.t_Type
                              }
                            ]
                          in
                          FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 4);
                          Rust_primitives.Hax.array_of_list list)
                      <:
                      Alloc.Boxed.t_Box (array Candid.Types.Internal.t_Field 4sz)
                        Alloc.Alloc.t_Global)
                  <:
                  Alloc.Boxed.t_Box (slice Candid.Types.Internal.t_Field) Alloc.Alloc.t_Global)
              <:
              Alloc.Vec.t_Vec Candid.Types.Internal.t_Field Alloc.Alloc.t_Global)));
    id = (fun  -> Candid.Types.Internal.of_under_impl);
    idl_serialize
    =
    fun (self: t_Order) (v___serializer: v___s) ->
      Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* ser:_ =
            match
              Core.Ops.Try_trait.Try.branch (Candid.Types.Serializer.serialize_struct v___serializer
                  <:
                  Core.Result.t_Result _ _)
            with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist3:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist3)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Lob_backend.Order.f_id
          in
          let ser = tmp0 in
          let hoist5:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist6:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist5
          in
          let* _:Prims.unit =
            match hoist6 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist4:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist4)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Lob_backend.Order.f_side
          in
          let ser = tmp0 in
          let hoist8:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist9:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist8
          in
          let* _:Prims.unit =
            match hoist9 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist7:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist7)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Lob_backend.Order.f_quantity
          in
          let ser = tmp0 in
          let hoist11:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist12:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist11
          in
          let* _:Prims.unit =
            match hoist12 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist10:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist10)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Lob_backend.Order.f_price
          in
          let ser = tmp0 in
          let hoist14:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist15:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist14
          in
          let* _:Prims.unit =
            match hoist15 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist13:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist13)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Core.Result.Result_Ok ()))
  }

let v___1: Prims.unit = ()

type t_Match = {
  f_bid_id:u64;
  f_ask_id:u64;
  f_price:u64;
  f_quantity:u64
}

let impl: Candid.Types.t_CandidType t_Match =
  {
    _ty
    =
    (fun  ->
        Core.Convert.Into.into (Candid.Types.Internal.TypeInner_Record
            (Alloc.Slice.into_vec_under_impl (Rust_primitives.unsize (Rust_primitives.Hax.box_new (let
                          list =
                            [
                              {
                                Candid.Types.Internal.Field.f_id
                                =
                                Core.Convert.Into.into (Candid.Types.Internal.Label_Named
                                    (Alloc.String.ToString.to_string "ask_id"
                                      <:
                                      Alloc.String.t_String))
                                <:
                                Alloc.Rc.t_Rc Candid.Types.Internal.t_Label;
                                Candid.Types.Internal.Field.f_ty
                                =
                                Candid.Types.CandidType.ty <: Candid.Types.Internal.t_Type
                              };
                              {
                                Candid.Types.Internal.Field.f_id
                                =
                                Core.Convert.Into.into (Candid.Types.Internal.Label_Named
                                    (Alloc.String.ToString.to_string "quantity"
                                      <:
                                      Alloc.String.t_String))
                                <:
                                Alloc.Rc.t_Rc Candid.Types.Internal.t_Label;
                                Candid.Types.Internal.Field.f_ty
                                =
                                Candid.Types.CandidType.ty <: Candid.Types.Internal.t_Type
                              };
                              {
                                Candid.Types.Internal.Field.f_id
                                =
                                Core.Convert.Into.into (Candid.Types.Internal.Label_Named
                                    (Alloc.String.ToString.to_string "price"
                                      <:
                                      Alloc.String.t_String))
                                <:
                                Alloc.Rc.t_Rc Candid.Types.Internal.t_Label;
                                Candid.Types.Internal.Field.f_ty
                                =
                                Candid.Types.CandidType.ty <: Candid.Types.Internal.t_Type
                              };
                              {
                                Candid.Types.Internal.Field.f_id
                                =
                                Core.Convert.Into.into (Candid.Types.Internal.Label_Named
                                    (Alloc.String.ToString.to_string "bid_id"
                                      <:
                                      Alloc.String.t_String))
                                <:
                                Alloc.Rc.t_Rc Candid.Types.Internal.t_Label;
                                Candid.Types.Internal.Field.f_ty
                                =
                                Candid.Types.CandidType.ty <: Candid.Types.Internal.t_Type
                              }
                            ]
                          in
                          FStar.Pervasives.assert_norm (Prims.eq2 (List.Tot.length list) 4);
                          Rust_primitives.Hax.array_of_list list)
                      <:
                      Alloc.Boxed.t_Box (array Candid.Types.Internal.t_Field 4sz)
                        Alloc.Alloc.t_Global)
                  <:
                  Alloc.Boxed.t_Box (slice Candid.Types.Internal.t_Field) Alloc.Alloc.t_Global)
              <:
              Alloc.Vec.t_Vec Candid.Types.Internal.t_Field Alloc.Alloc.t_Global)));
    id = (fun  -> Candid.Types.Internal.of_under_impl);
    idl_serialize
    =
    fun (self: t_Match) (v___serializer: v___s) ->
      Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* ser:_ =
            match
              Core.Ops.Try_trait.Try.branch (Candid.Types.Serializer.serialize_struct v___serializer
                  <:
                  Core.Result.t_Result _ _)
            with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist16:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist16)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Lob_backend.Match.f_ask_id
          in
          let ser = tmp0 in
          let hoist18:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist19:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist18
          in
          let* _:Prims.unit =
            match hoist19 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist17:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist17)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Lob_backend.Match.f_quantity
          in
          let ser = tmp0 in
          let hoist21:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist22:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist21
          in
          let* _:Prims.unit =
            match hoist22 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist20:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist20)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Lob_backend.Match.f_price
          in
          let ser = tmp0 in
          let hoist24:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist25:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist24
          in
          let* _:Prims.unit =
            match hoist25 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist23:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist23)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          let tmp0, out:(_ & Core.Result.t_Result Prims.unit _) =
            Candid.Types.Compound.serialize_element ser self.Lob_backend.Match.f_bid_id
          in
          let ser = tmp0 in
          let hoist27:(_ & Core.Result.t_Result Prims.unit _) = out in
          let hoist28:Core.Ops.Control_flow.t_ControlFlow _ _ =
            Core.Ops.Try_trait.Try.branch hoist27
          in
          let* _:Prims.unit =
            match hoist28 with
            | Core.Ops.Control_flow.ControlFlow_Break residual ->
              let* hoist26:Rust_primitives.Hax.t_Never =
                Core.Ops.Control_flow.ControlFlow.v_Break (Core.Ops.Try_trait.FromResidual.from_residual
                      residual
                    <:
                    Core.Result.t_Result Prims.unit _)
              in
              Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist26)
            | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
              Core.Ops.Control_flow.ControlFlow_Continue v_val
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Core.Result.Result_Ok ()))
  }

let v___2: Prims.unit = ()

let is_match (order other: t_Order) : bool =
  Prims.op_AmpAmp (Prims.op_AmpAmp (Prims.op_AmpAmp (order.Lob_backend.Order.f_quantity >. 0uL)
            (other.Lob_backend.Order.f_quantity >. 0uL))
        (order.Lob_backend.Order.f_side <>. other.Lob_backend.Order.f_side))
    (Prims.op_BarBar (Prims.op_AmpAmp (order.Lob_backend.Order.f_side =. Side_Buy)
            (order.Lob_backend.Order.f_price >=. other.Lob_backend.Order.f_price))
        (Prims.op_AmpAmp (order.Lob_backend.Order.f_side =. Side_Sell)
            (order.Lob_backend.Order.f_price <=. other.Lob_backend.Order.f_price)))

let try_match_under_impl (self other: t_Order) : Core.Option.t_Option t_Match =
  if is_match self other
  then
    let quantity:u64 =
      Core.Cmp.min self.Lob_backend.Order.f_quantity other.Lob_backend.Order.f_quantity
    in
    let bid_id, ask_id:(u64 & u64) =
      if self.Lob_backend.Order.f_side =. Side_Buy
      then self.Lob_backend.Order.f_id, other.Lob_backend.Order.f_id
      else other.Lob_backend.Order.f_id, self.Lob_backend.Order.f_id
    in
    Core.Option.Option_Some
    ({
        Lob_backend.Match.f_bid_id = bid_id;
        Lob_backend.Match.f_ask_id = ask_id;
        Lob_backend.Match.f_price = self.Lob_backend.Order.f_price;
        Lob_backend.Match.f_quantity = quantity
      })
  else Core.Option.Option_None

let impl: Core.Cmp.t_PartialOrd t_Order t_Order =
  {
    partial_cmp
    =
    fun (self: t_Order) (other: t_Order) -> Core.Option.Option_Some (Core.Cmp.Ord.cmp self other)
  }

let impl: Core.Cmp.t_Ord t_Order =
  {
    cmp
    =
    fun (self: t_Order) (other: t_Order) ->
      Core.Cmp.then_under_impl (Core.Cmp.Ord.cmp self.Lob_backend.Order.f_price
            other.Lob_backend.Order.f_price
          <:
          Core.Cmp.t_Ordering)
        (Core.Cmp.Ord.cmp self.Lob_backend.Order.f_id other.Lob_backend.Order.f_id
          <:
          Core.Cmp.t_Ordering)
  }

let impl: Core.Convert.t_From t_Order (Core.Cmp.t_Reverse t_Order) =
  { from = fun (other: Core.Cmp.t_Reverse t_Order) -> other.Core.Cmp.Reverse.0 }

let impl: Core.Convert.t_From (Core.Cmp.t_Reverse t_Order) t_Order =
  { from = fun (value: t_Order) -> Core.Cmp.Reverse value }

type t_OrderBook = {
  f_bids:Alloc.Collections.Binary_heap.t_BinaryHeap t_Order;
  f_asks:Alloc.Collections.Binary_heap.t_BinaryHeap (Core.Cmp.t_Reverse t_Order)
}

let new_under_impl_5: t_OrderBook =
  {
    Lob_backend.OrderBook.f_bids = Alloc.Collections.Binary_heap.new_under_impl_9;
    Lob_backend.OrderBook.f_asks = Alloc.Collections.Binary_heap.new_under_impl_9
  }

let add_order_under_impl_5 (self: t_OrderBook) (order: t_Order)
    : (t_OrderBook & Alloc.Vec.t_Vec t_Match Alloc.Alloc.t_Global) =
  let _:Prims.unit =
    if ~.(order.Lob_backend.Order.f_quantity >. 0uL <: bool)
    then
      Rust_primitives.Hax.never_to_any (Core.Panicking.panic "assertion failed: order.quantity > 0"
          <:
          Rust_primitives.Hax.t_Never)
  in
  let _:Prims.unit =
    if ~.(order.Lob_backend.Order.f_price >. 0uL <: bool)
    then
      Rust_primitives.Hax.never_to_any (Core.Panicking.panic "assertion failed: order.price > 0"
          <:
          Rust_primitives.Hax.t_Never)
  in
  let self, output:(t_OrderBook & Alloc.Vec.t_Vec t_Match Alloc.Alloc.t_Global) =
    match order.Lob_backend.Order.f_side with
    | Side_Buy  ->
      let tmp0, out:(Alloc.Collections.Binary_heap.t_BinaryHeap (Core.Cmp.t_Reverse t_Order) &
        (Alloc.Vec.t_Vec t_Match Alloc.Alloc.t_Global & Core.Option.t_Option t_Order)) =
        process_order order self.Lob_backend.OrderBook.f_asks
      in
      let self:t_OrderBook = { self with Lob_backend.OrderBook.f_asks = tmp0 } in
      let matches, opt_remaining_bid:(Alloc.Collections.Binary_heap.t_BinaryHeap
        (Core.Cmp.t_Reverse t_Order) &
        (Alloc.Vec.t_Vec t_Match Alloc.Alloc.t_Global & Core.Option.t_Option t_Order)) =
        out
      in
      let self:t_OrderBook =
        match opt_remaining_bid with
        | Core.Option.Option_Some remaining_bid ->
          let self:t_OrderBook =
            {
              self with
              Lob_backend.OrderBook.f_bids
              =
              Alloc.Collections.Binary_heap.push_under_impl_9 self.Lob_backend.OrderBook.f_bids
                remaining_bid
            }
          in
          self
        | _ -> self
      in
      self, matches
    | Side_Sell  ->
      let tmp0, out:(Alloc.Collections.Binary_heap.t_BinaryHeap t_Order &
        (Alloc.Vec.t_Vec t_Match Alloc.Alloc.t_Global & Core.Option.t_Option t_Order)) =
        process_order order self.Lob_backend.OrderBook.f_bids
      in
      let self:t_OrderBook = { self with Lob_backend.OrderBook.f_bids = tmp0 } in
      let matches, opt_remaining_ask:(Alloc.Collections.Binary_heap.t_BinaryHeap t_Order &
        (Alloc.Vec.t_Vec t_Match Alloc.Alloc.t_Global & Core.Option.t_Option t_Order)) =
        out
      in
      let self:t_OrderBook =
        match opt_remaining_ask with
        | Core.Option.Option_Some remaining_ask ->
          let self:t_OrderBook =
            {
              self with
              Lob_backend.OrderBook.f_asks
              =
              Alloc.Collections.Binary_heap.push_under_impl_9 self.Lob_backend.OrderBook.f_asks
                (Core.Cmp.Reverse remaining_ask)
            }
          in
          self
        | _ -> self
      in
      self, matches
  in
  self, output

let list_bids_under_impl_5 (self: t_OrderBook) : Alloc.Vec.t_Vec t_Order Alloc.Alloc.t_Global =
  Core.Iter.Traits.Iterator.Iterator.collect (Core.Iter.Traits.Iterator.Iterator.cloned (Alloc.Collections.Binary_heap.iter_under_impl_10
            self.Lob_backend.OrderBook.f_bids
          <:
          Alloc.Collections.Binary_heap.t_Iter t_Order)
      <:
      Core.Iter.Adapters.Cloned.t_Cloned (Alloc.Collections.Binary_heap.t_Iter t_Order))

let list_asks_under_impl_5 (self: t_OrderBook) : Alloc.Vec.t_Vec t_Order Alloc.Alloc.t_Global =
  Core.Iter.Traits.Iterator.Iterator.collect (Core.Iter.Traits.Iterator.Iterator.map (Core.Iter.Traits.Iterator.Iterator.cloned
            (Alloc.Collections.Binary_heap.iter_under_impl_10 self.Lob_backend.OrderBook.f_asks
              <:
              Alloc.Collections.Binary_heap.t_Iter (Core.Cmp.t_Reverse t_Order))
          <:
          Core.Iter.Adapters.Cloned.t_Cloned
          (Alloc.Collections.Binary_heap.t_Iter (Core.Cmp.t_Reverse t_Order)))
        (fun (Core.Cmp.Reverse order) -> order)
      <:
      Core.Iter.Adapters.Map.t_Map
        (Core.Iter.Adapters.Cloned.t_Cloned
          (Alloc.Collections.Binary_heap.t_Iter (Core.Cmp.t_Reverse t_Order)))
        (Core.Cmp.t_Reverse t_Order -> t_Order))

let process_order
      (#t: Type)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __0: Core.Marker.t_Sized t)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __1: Core.Convert.t_Into t t_Order)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __2: Core.Convert.t_From t t_Order)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __3: Core.Cmp.t_Ord t)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __4: Core.Clone.t_Clone t)
      (order: t_Order)
      (other_side: Alloc.Collections.Binary_heap.t_BinaryHeap t)
    : (Alloc.Collections.Binary_heap.t_BinaryHeap t &
      (Alloc.Vec.t_Vec t_Match Alloc.Alloc.t_Global & Core.Option.t_Option t_Order)) =
  let matches:Alloc.Vec.t_Vec t_Match Alloc.Alloc.t_Global = Alloc.Vec.new_under_impl in
  let done:bool = false in
  let done, matches, order, other_side:(bool & Alloc.Vec.t_Vec t_Match Alloc.Alloc.t_Global &
    t_Order &
    Alloc.Collections.Binary_heap.t_BinaryHeap t) =
    Core.Iter.Traits.Iterator.Iterator.fold (Core.Iter.Traits.Collect.IntoIterator.into_iter ({
              Core.Ops.Range.Range.f_start = 1sz;
              Core.Ops.Range.Range.f_end
              =
              Alloc.Collections.Binary_heap.len_under_impl_10 other_side <: usize
            })
        <:
        _)
      (done, matches, order, other_side)
      (fun (done, matches, order, other_side) v__i ->
          if ~.done <: bool
          then
            match
              Core.Option.and_then_under_impl (Alloc.Collections.Binary_heap.peek_under_impl_10 other_side

                  <:
                  Core.Option.t_Option t)
                (fun other ->
                    try_match_under_impl (Core.Convert.Into.into (Core.Clone.Clone.clone other <: t)
                        <:
                        t_Order)
                      order
                    <:
                    Core.Option.t_Option t_Match)
              <:
              Core.Option.t_Option t_Match
            with
            | Core.Option.Option_Some m ->
              let order:t_Order =
                {
                  order with
                  Lob_backend.Order.f_quantity
                  =
                  order.Lob_backend.Order.f_quantity -. m.Lob_backend.Match.f_quantity
                }
              in
              let tmp0, out:(Alloc.Collections.Binary_heap.t_BinaryHeap t & Core.Option.t_Option t)
              =
                Alloc.Collections.Binary_heap.pop_under_impl_9 other_side
              in
              let other_side:Alloc.Collections.Binary_heap.t_BinaryHeap t = tmp0 in
              let hoist29:(Alloc.Collections.Binary_heap.t_BinaryHeap t & Core.Option.t_Option t) =
                out
              in
              let hoist30:t = Core.Option.unwrap_under_impl hoist29 in
              let (other: t_Order):t_Order = Core.Convert.Into.into hoist30 in
              let other:t_Order =
                {
                  other with
                  Lob_backend.Order.f_quantity
                  =
                  other.Lob_backend.Order.f_quantity -. m.Lob_backend.Match.f_quantity
                }
              in
              let other_side:Alloc.Collections.Binary_heap.t_BinaryHeap t =
                if other.Lob_backend.Order.f_quantity >. 0uL
                then
                  let other_side:Alloc.Collections.Binary_heap.t_BinaryHeap t =
                    Alloc.Collections.Binary_heap.push_under_impl_9 other_side
                      (Core.Convert.From.from (Core.Clone.Clone.clone other <: t_Order) <: t)
                  in
                  other_side
                else other_side
              in
              let matches:Alloc.Vec.t_Vec t_Match Alloc.Alloc.t_Global =
                Alloc.Vec.push_under_impl_1 matches m
              in
              done, matches, order, other_side
            | _ ->
              let done:bool = true in
              done, matches, order, other_side
          else done, matches, order, other_side)
  in
  let output:(Alloc.Vec.t_Vec t_Match Alloc.Alloc.t_Global & Core.Option.t_Option t_Order) =
    matches,
    (if order.Lob_backend.Order.f_quantity >. 0uL
      then Core.Option.Option_Some order
      else Core.Option.Option_None)
  in
  other_side, output