<template>
  <div>
    <div class="grid grid-cols-4 gap-5">
      <div v-for="p in products">
        <!-- v-for (to make a foreach loop) each item get in a p to split them all up -->
        <ProductCard :product="p" />
      </div>
    </div>
  </div>
</template>

<script setup>
definePageMeta({
  layout: "products",
});

// fecth the products
const { data: products } = await useFetch("https://fakestoreapi.com/products"); // Get all the data form the fakestore and put it in a array where we give it the name products
useHead({
  // useHead says we get the meta from nuxt.config.ts and rewrite to match the site
  title: "Eco Fashion | Merch",
  meta: [{ name: "description", content: "Eco Fashion Mecrh" }],
});
</script>

<style scoped></style>
