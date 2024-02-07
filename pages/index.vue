<template>
  <img
    src="https://unsplash.it/1920/300"
    alt="Hero-billede"
    class="herobillede"
  />
  <div class="card">
    <Carousel
      :value="products"
      :numVisible="5"
      :numScroll="1"
      :responsiveOptions="responsiveOptions"
      circular
      :autoplayInterval="3000"
    >
      <template #item="slotProps">
        <div class="border-1 surface-border border-round m-2 p-3">
          <div class="mb-3 image align-middle">
            <div class="relative mx-auto">
              <img
                :src="slotProps.data.image"
                :alt="slotProps.data.name"
                class="w-full border-round carousel"
              />
            </div>
          </div>
          <div class="mb-3 font-medium">{{ slotProps.data.name }}</div>
          <div class="flex justify-content-between align-items-center">
            <div class="mt-0 font-semibold text-xl">
              ${{ slotProps.data.price }}
            </div>
            <span>
              <Button icon="pi pi-heart" severity="secondary" outlined />
              <Button icon="pi pi-shopping-cart" class="ml-2" />
            </span>
          </div>
        </div>
      </template>
    </Carousel>
  </div>
</template>

<script setup>
import Carousel from "primevue/carousel";
import { ref, onMounted } from "vue";

const products = ref([]);

const responsiveOptions = ref([
  {
    breakpoint: "1400px",
    numVisible: 5,
    numScroll: 1,
  },
  {
    breakpoint: "1199px",
    numVisible: 5,
    numScroll: 1,
  },
  {
    breakpoint: "767px",
    numVisible: 2,
    numScroll: 1,
  },
  {
    breakpoint: "575px",
    numVisible: 1,
    numScroll: 1,
  },
]);

onMounted(async () => {
  try {
    const response = await fetch("https://fakestoreapi.com/products");
    if (!response.ok) {
      throw new Error("Failed to fetch products");
    }
    const data = await response.json();
    products.value = data;
  } catch (error) {
    console.error(error);
  }
});
</script>

<style scoped>
* {
  margin: 0;
  padding: 0;
}
.card {
  margin: 0;
  padding: 0;
}
.carousel {
  display: flex;
  justify-content: center;
  align-items: center;
  max-height: 150px;
  max-width: 150px;
}
.herobillede {
  width: 100vw;
}
image {
  padding: 20px;
}
</style>
