var orderItems ={};
var cartItemsFromDb = undefined;

const addToCart = (event) => {
  cartOrderItemId = event.target.dataset.id
  this.orderItems[cartOrderItemId] = 1;
  if (this.orderItems[cartOrderItemId]== this.cartItemsFromDb[cartOrderItemId]){
    delete this.orderItems[cartOrderItemId];
  }

  for(let element of $(`.cart_item_quantity_box_${cartOrderItemId}`)){
    console.log(element)
    element.innerHTML = this.orderItems[cartOrderItemId]!=undefined ? this.orderItems[cartOrderItemId] : this.cartItemsFromDb[cartOrderItemId]
  };
  for(let element of $(`.CartActionButtons_${cartOrderItemId}`)){
    element.classList.remove("hideElement")
  }
  for(let element of $(`.AddToCartButton_${cartOrderItemId}`)){
    element.classList.add("hideElement")
  }
  $('#client_cart_items')[0].value = JSON.stringify(this.orderItems);
}

const addOrderItem = (event) => {
  cartOrderItemId = event.target.dataset.id
  this.orderItems[cartOrderItemId] =(this.orderItems[cartOrderItemId]!=undefined ? this.orderItems[cartOrderItemId] :this.cartItemsFromDb[cartOrderItemId]) + 1 ;
  if (this.orderItems[cartOrderItemId]== this.cartItemsFromDb[cartOrderItemId]){
    delete this.orderItems[cartOrderItemId];
  }
  for(let element of $(`.cart_item_quantity_box_${cartOrderItemId}`)){
    element.innerHTML = this.orderItems[cartOrderItemId] ? this.orderItems[cartOrderItemId] : this.cartItemsFromDb[cartOrderItemId]
  }
  $('#client_cart_items')[0].value = JSON.stringify(this.orderItems);
}
const removeOrderItem = (event) =>{
  cartOrderItemId = event.target.dataset.id
  if(this.orderItems[cartOrderItemId]==1 || (this.orderItems[cartOrderItemId]==undefined && this.cartItemsFromDb[cartOrderItemId]==1)){
    for(let element of $(`.CartActionButtons_${cartOrderItemId}`)){
        element.classList.add("hideElement")
    }
    for(let element of $(`.AddToCartButton_${cartOrderItemId}`)){
      element.classList.remove("hideElement")
    }

    if (!this.cartItemsFromDb[cartOrderItemId]) {
      delete this.orderItems[cartOrderItemId];
    }
    else {
      this.orderItems[cartOrderItemId] = 0 ;
    }
  }else {
    this.orderItems[cartOrderItemId]  = (this.orderItems[cartOrderItemId]!=undefined ? this.orderItems[cartOrderItemId] : this.cartItemsFromDb[cartOrderItemId]) - 1 ;
  }

  if (this.orderItems[cartOrderItemId]== this.cartItemsFromDb[cartOrderItemId]){
    delete this.orderItems[cartOrderItemId];
  }

  for(let element of $(`.cart_item_quantity_box_${cartOrderItemId}`)){
    element.innerHTML = this.orderItems[cartOrderItemId] ? this.orderItems[cartOrderItemId] : this.cartItemsFromDb[cartOrderItemId]
  }
  $('#client_cart_items')[0].value = JSON.stringify(this.orderItems);
}


jQuery(document).ready(function(){
  cartItemsFromDb = ($('#cart_items_from_db')[0]!=undefined ) ? JSON.parse($('#cart_items_from_db')[0].dataset.source): undefined;

})

