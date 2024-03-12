<template>
  <div v-for="item in cart" :key="item.id">
    <div class="produkt">
      <img :src="item.image" alt="product" />
      <div class="produktinfo">
        <div>
          <h2>{{ item.title }}</h2>
          <div>
            <p v-if="item.color">color - {{ item.color }}</p>
            <p v-else>color - Unkown</p>
          </div>
          <div>
            <p v-if="item.size">size - {{ item.size }}</p>
            <p v-else>size - Unkown</p>
          </div>
        </div>
        <InputNumber
          v-model="antal"
          showButtons
          buttonLayout="vertical"
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
        <p>${{ item.price.toFixed(2) }}</p>
        <button
          class="btn bg-red-400 pi pi-trash"
          @click="removeFromCart(item)"
        ></button>
      </div>
    </div>
  </div>
  <div>total price {{ totalPrice.toFixed(2) }}</div>
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
  width: 5%;
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
  height: 75px;
  width: 75px;
}
.produkt div {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
}
.produktinfo {
  flex-grow: 1;
}
.produktinfo div div {
  display: flex;
  align-items: flex-start;
  width: 100%;
  margin-left: 10px;
}
.produktinfo .p-inputwrapper .p-inputnumber-input {
  width: 20px;
}
.produkt div div {
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  padding-left: 5px;
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
.delete p {
  margin: 5px;
}
</style>
