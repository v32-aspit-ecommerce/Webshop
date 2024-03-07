<template>
  <div class="kurv">
    <div class="centering">
      <div class="produkt">
        <img src="https://unsplash.it/100/100" alt="produktbillede" />
        <div class="produktinfo">
          <div v-for="item in cart" :key="item.id"></div>
          <h4>Produktnavn</h4>
          <div>
            <p>Farve</p>
            |
            <p>Størrelse</p>
          </div>
          <InputNumber
            v-model="antal"
            showButtons
            buttonLayout="horizontal"
            :min="1"
            :max="99"
          >
            <template #incrementbuttonicon>
              <span class="pi pi-plus" />
            </template>
            <template #decrementbuttonicon>
              <span class="pi pi-minus" />
            </template>
          </InputNumber>
        </div>
        <div class="delete">
          <h4>99,-</h4>
          <Button icon="pi pi-trash" />
        </div>
      </div>
      <div class="flex justify-content-center kupon">
        <InputText type="text" v-model="value" />
        <Button label="Apply" class="apply" />
      </div>
      <div>
        <div class="stats">
          <h3>Subtotal: ${{ totalPrice.toFixed(2) }}</h3>
        </div>
        <div class="stats">
          <p>Shipping</p>
          <p>Free</p>
        </div>
        <div class="stats">
          <h3>Total Price: ${{ totalPrice.toFixed(2) }}</h3>
        </div>
      </div>
    </div>

    <h2>{{ item.title }}</h2>
    <p>Price - ${{ item.price.toFixed(2) }}</p>
    <button class="btn bg-red-400" @click="removeFromCart(item)">Delete</button>
    <hr class="mt-1" />
  </div>
</template>

<script setup>
import { ref } from "vue";
import Button from "primevue/button";
const value = ref(null);
const antal = ref(1);
const cart = useState("shoppingcart");

const removeFromCart = (itemToRemove) => {
  const index = cart.value.findIndex((item) => item === itemToRemove);
  if (index !== -1) {
    cart.value.splice(index, 1);
  }
};

const totalPrice = computed(() => {
  return cart.value.reduce((total, item) => total + item.price, 0);
});
</script>

<style scoped>
.back {
  display: flex;
  flex-direction: row;
}
.indbetal {
  background-color: rgb(242, 242, 242);
  width: 50vw;
  padding-bottom: 50px;
}
.indbetal div:nth-child(1) {
  height: 100px;
}
.indbetal div nav {
  background-color: transparent;
}

.centering {
  width: 80%;
  margin: 0 auto;
}
.centering:nth-of-type(1) {
  margin-top: 100px;
}
.kurv {
  width: 50vw;
  background-color: rgb(250, 250, 250);
  height: auto;
  display: flex;
  flex-direction: column;
}
.check {
  display: flex;
  justify-content: flex-start;
  margin-left: 5px;
}
.check p {
  margin-left: 10px;
}
select,
h2 {
  margin-left: 10px;
  margin-bottom: 5px;
  margin-top: 5px;
}
input {
  border: solid;
  border-color: rgb(218, 218, 218);
  width: 45%;
  margin: 10px;
}
.p-inputtext {
  width: 100%;
}
.centering div div .p-inputnumber {
  margin-left: 10px;
  height: 30px;
  width: 100%;
}
.flex {
  align-items: center;
}
.produkt {
  display: flex;
}
.produkt img {
  margin: 10px;
  border-radius: 10px;
}
.produkt div {
  display: flex;
  justify-content: space-between;
}
.produktinfo {
  display: flex;
  flex-direction: column;
  flex-grow: 1;
}
.produktinfo .p-inputnumber-input {
  width: 20px;
}
.produkt div div {
  display: flex;
  flex-direction: row;
  justify-content: flex-start;
  align-items: center;
}
.kupon {
  height: 50px;
  background-color: rgb(250, 250, 250);
}
.produktinfo button {
  width: 20px;
}
.apply {
  width: 10%;
  background-color: rgb(203, 186, 211);
}
.stats {
  display: flex;
  justify-content: space-between;
}
.delete {
  flex-direction: column;
  align-items: center;
  margin-bottom: 3px;
}
</style>
