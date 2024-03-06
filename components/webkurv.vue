<template>
  <div class="kurv">
    <div class="centering">
      <div class="produkt">
        <img src="https://unsplash.it/100/100" alt="produktbillede" />
        <div class="produktinfo">
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
          <p>Subtotal</p>
          <p>99,-</p>
        </div>
        <div class="stats">
          <p>Shipping</p>
          <p>Free</p>
        </div>
        <div class="stats">
          <p>Total</p>
          <p>99,-</p>
        </div>
      </div>
    </div>
  </div>
  <div v-for="item in cart" :key="item.id">
    <h2>{{ item.title }}</h2>
    <p>Price - ${{ item.price }}</p>
  </div>
</template>

<script setup>
import { ref } from "vue";
import Button from "primevue/button";
const value = ref(null);
const antal = ref(1);
const cart = useState("shoppingcart");
</script>

<style scoped></style>
