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

import { ref } from "vue"; // Importer ref fra Vue for at oprette reaktive variabler

// Opret en reaktiv variabel til at gemme produkterne
const products = ref([]);

// Kald fetch hooken til at hente data fra API'en
fetch("https://fakestoreapi.com/products")
  .then((response) => response.json()) // Konverter responsen til JSON-format
  .then((data) => {
    // Filtrér produkterne, så kun dem med kategorien "men's clothing" er tilbage
    products.value = data.filter(
      (product) => product.category === "men's clothing"
    );
    console.dir(products.value); // Inspektion af de hentede produkter
  })
  .catch((error) => console.error(error)); // Håndtering af eventuelle fejl

useHead({
  // useHead says we get the meta from nuxt.config.ts and rewrite to match the site
  title: "Eco Fashion | Merch",
  meta: [{ name: "description", content: "Eco Fashion Mecrh" }],
});
</script>

<style scoped></style>
