<template>
  <div class="card flex justify-center">
    <Sidebar
      v-model:visible="visibleRight"
      header="Your Cart"
      position="right"
      class="w-2/6"
    >
      <ProductCardSidebar :product="product" />
    </Sidebar>
    <Button icon="pi pi-shopping-bag" @click="visibleRight = true" />
  </div>
</template>

<script setup>
import "primeicons/primeicons.css";
import { ref } from "vue";

const visibleRight = ref(false);

const { id } = useRoute().params; // We use useRoute to get the the name that its changing too ... like $_GET = "id" from php
const uri = "https://fakestoreapi.com/products/" + id; // know we know what id got send then we say link + id to get the right item

//fetch the products
const { data: product } = await useFetch(uri, { key: id }); // Get all the item content from uri and put it in a array to filter content out

//Filter to cart
const selectedProducts = ref([]);
</script>

<style scoped>
button {
  transition: 1s;
}
button:hover {
  background-color: grey;
}
</style>
