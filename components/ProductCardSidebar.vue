<template>
  <div class="card">
    <div class="flex">
      <div class="p-7">
        <img :src="product.image" alt="product image" class="thumb" />
      </div>
      <div class="flex">
        <h2 class="text-2xl my-7">{{ product.title }}</h2>
        <p class="text-xl my-7 mx-7">${{ product.price }}</p>
      </div>
    </div>
  </div>
</template>

<script setup>
const { product } = defineProps(["product"]);
</script>

<style scoped>
.thumb {
  width: 100px;
  border-radius: 5px;
}
</style>
