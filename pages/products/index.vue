<template>
  <div>
    <CategoryFilter />
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
import { ref } from "vue";
import { useRouter } from "vue-router"; // Importer useRouter fra vue-router

// Opret en reaktiv variabel til at gemme produkterne
const products = ref([]);

// Hent router-instansen
const router = useRouter();

// Hent værdien af "item" fra URL'en
const itemFromUrl = router.currentRoute.value.query.item;

// Hent alle produkter fra API'en
fetch("https://fakestoreapi.com/products")
  .then((response) => response.json())
  .then((data) => {
    // Filtrér produkterne baseret på elementet fra URL'en
    if (itemFromUrl === "mand") {
      products.value = data.filter(
        (product) => product.category === "men's clothing"
      );
    } else if (itemFromUrl === "kvinde") {
      products.value = data.filter(
        (product) => product.category === "women's clothing"
      );
    } else if (itemFromUrl === "jewelery") {
      products.value = data.filter(
        (product) => product.category === "jewelery"
      ); // Stavemåde rettet
    } else if (itemFromUrl === "electronics") {
      products.value = data.filter(
        (product) => product.category === "electronics"
      ); // Stavemåde rettet
    } else if (itemFromUrl === "new") {
      products.value = data.filter((product) => product.category === "new"); // Stavemåde rettet
    } else {
      products.value = data; // Hvis item ikke er specificeret, vis alle produkter og hvis der er en der prøver at skrive et product oppe i url så bliver de smit tilbage til product
    }
    console.dir(products.value);
  })
  .catch((error) => console.error(error));
</script>

<style scoped></style>
