<template>
  <div class="herobillede">
    <img src="https://unsplash.it/1920/300" alt="Hero-billede" />
    <p class="herotext">
      We make clothes with love, designed to spark the conversation, and support
      animal rescue too
    </p>
  </div>
  <h2>New Products</h2>
  <div class="cards">
    <Carousel
      :value="products"
      :numVisible="5"
      :numScroll="1"
      :responsiveOptions="responsiveOptions"
      circular
      :autoplayInterval="3000"
      :showIndicators="false"
      class="card"
    >
      <template #item="slotProps">
        <div
          class="border-1 surface-border border-round m-2 p-3 item itemCenter"
        >
          <div class="mb-3 image align-middle imgboks">
            <div class="relative">
              <img
                :src="slotProps.data.image"
                :alt="slotProps.data.name"
                class="w-full border-round thumb"
              />
            </div>
          </div>
          <div class="mb-3 font-medium">
            {{ slotProps.data.name }}
          </div>
          <div
            class="flex justify-content-between align-items-center flex-col buywidth"
          >
            <p class="font-bold text-gray-500 m-4 truncate flextext">
              {{ slotProps.data.title }}
            </p>
            <div class="font-bold text-gray-500 m-4 truncate textcenter">
              Price - ${{ slotProps.data.price }}
            </div>
            <span>
              <NuxtLink :to="`/products/${slotProps.data.id}`">
                <p class="btn my-4 text-center">View Details</p>
              </NuxtLink>
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
    const sortedProducts = data
      .sort((a, b) => b.timestamp - a.timestamp)
      .slice(0, 10);
    products.value = sortedProducts;
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
h2 {
  padding: 20px;
  text-align: center;
  font-weight: bold;
}
.cards {
  display: flex;
  justify-content: center;
  padding-bottom: 50px;
}
.card {
  display: flex;
  justify-content: center;
  max-width: 80vw;
  padding: 20px 0;
}
.p-carousel-content {
  justify-content: center;
}
.item {
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  align-items: center;
  padding: 0 1rem;
  height: 245px;
  max-width: 235px;
}

.thumb {
  display: flex;
  max-height: 150px;
  max-width: 150px;
}
.herobillede {
  width: 100%;
}
.carousel img {
  padding: 20px;
}
.p-carousel-item {
  display: flex;
  justify-content: center;
}
.buybutton {
  width: 100%;
  height: 35px;
}
.buywidth {
  width: 100%;
}
.imgboks {
  display: flex;
  width: 100%;
  height: 100%;
  align-items: center;
  justify-content: center;
}
.textcenter {
  text-align: center;
}

.herobillede {
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
}
.herotext {
  display: flex;
  position: absolute;
  width: 50%;
  top: calc(50% - 40px);
  color: white;
  font-size: 40px;
  line-height: 40px;
  text-shadow: -1px -1px 0 #000, 1px -1px 0 #000, -1px 1px 0 #000,
    1px 1px 0 #000;
  text-align: center;
}
.itemCenter {
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>
