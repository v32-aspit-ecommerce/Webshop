<template>
  <div>
    <!-- Kort til filtreringsmuligheder -->
    <div class="pb-4">
      <Card>
        <template #content>
          <!-- Chip-komponenten viser aktive filtre -->
          <div class="p-fluid pb-4">
            <Chips
              v-model="activeFilters"
              :removable="true"
              @remove="removeFilter($event)"
            ></Chips>

            <button @click="clearAllFilters" class="clear-all-btn">
              Clear All
            </button>
          </div>
          <!-- Slider til priser -->
          <div class="w-44 slidercard px-4 pt-2 pb-6">
            <p class="pb-2">Pris</p>
            <div class="pb-4">
              <!-- Input til minimumspris -->
              <InputText
                v-model.number="priceRange.min"
                class="w-full mb-3 slidercard"
              />
              <!-- Slider til minimumspris -->
              <Slider
                v-model="priceRange.min"
                class="w-full"
                :max="1000"
                :min="1"
              />
            </div>

            <div>
              <!-- Input til maksimumspris -->
              <InputText
                v-model.number="priceRange.max"
                class="w-full mb-3 slidercard"
              />
              <!-- Slider til maksimumspris -->
              <Slider
                v-model="priceRange.max"
                class="w-full"
                :max="1000"
                :min="1"
              />
            </div>
          </div>
          <!-- Filtrering efter farver -->
          <div class="flex gap-5 pt-4">
            <div class="filtercard">Brand (i)</div>
            <div class="filtercard">
              <p>Colors</p>
              <!-- Chips for farver -->
              <div class="flex flex-wrap justify-center">
                <div
                  v-for="color in colors"
                  :key="color"
                  class="chip"
                  :class="{
                    'chip-active': activeColors.includes(color),
                    [`bg-${color}`]: true,
                  }"
                  @click="toggleColor(color)"
                >
                  <div class="bg-icon" v-if="activeColors.includes(color)">
                    <i class="pi pi-check"></i>
                  </div>
                </div>
              </div>
            </div>
            <div class="filtercard">Size (i)</div>
          </div>
        </template>
      </Card>
    </div>

    <!-- Visning af filtrerede produkter -->
    <div v-if="filteredProducts.length > 0">
      <div class="grid grid-cols-4 gap-5">
        <div
          v-for="product in filteredProducts"
          :key="product.id"
          class="card text-center"
        >
          <img :src="product.image" alt="product thumb" class="thumb" />
          <p class="font-bold text-gray-500 m-4 truncate">
            {{ product.title }}
          </p>
          <p class="font-bold text-gray-500 m-4 truncate">
            Price - ${{ product.price }}
          </p>
          <NuxtLink :to="`/products/${product.id}`">
            <p class="btn my-4">View Details</p>
          </NuxtLink>
        </div>
      </div>
    </div>
    <!-- Ingen produkter fundet med de aktive filtre -->
    <div v-else>
      <p>No products found.</p>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watchEffect } from "vue";
import "primeicons/primeicons.css";

// Refs til forskellige filtre og data
const selectedPrices = ref([]);
const selectedCategory = ref("");
const priceRange = ref({ min: 1, max: 1000 });
const activeFilters = ref([]);
const activeColors = ref([]);

// Beregning af filtrerede produkter
const filteredProducts = computed(() => {
  const isFilterActive =
    selectedPrices.value.length > 0 ||
    (priceRange.value.min > 0 && priceRange.value.max < Infinity) ||
    selectedCategory.value !== "" ||
    activeColors.value.length > 0;

  if (!isFilterActive) {
    return products.value;
  } else {
    return products.value.filter(
      (product) =>
        (selectedPrices.value.length === 0 ||
          selectedPrices.value.includes(product.price)) &&
        (selectedCategory.value === "" ||
          product.category === selectedCategory.value) &&
        (priceRange.value.min === 1 || product.price >= priceRange.value.min) &&
        (priceRange.value.max === 1000 ||
          product.price <= priceRange.value.max) &&
        (activeColors.value.length === 0 ||
          activeColors.value.includes(product.color))
    );
  }
});

// Fjernelse af filter
function removeFilter(filter) {
  const index = activeFilters.value.indexOf(filter);
  if (index !== -1) {
    activeFilters.value.splice(index, 1);
  }
}

// Hent produkter fra API
const { data: products } = await useAsyncData(() =>
  fetch("https://fakestoreapi.com/products").then((res) => res.json())
);

// Tilføj en ID-egenskab til hvert produktobjekt
products.value.forEach((product, index) => {
  product.id = index + 1;
});

// Farver til valg
const colors = ["black", "orange", "indigo", "gray", "cyan", "pink"];

// Funktion til at tilføje/fjerne en farve fra listen over aktive farver
const toggleColor = (color) => {
  if (activeColors.value.includes(color)) {
    activeColors.value = activeColors.value.filter((c) => c !== color);
    activeFilters.value = activeFilters.value.filter((f) => f !== color);
  } else {
    activeColors.value.push(color);
    activeFilters.value.push(color);
  }
};

// Metode til at fjerne alle aktive filtre
const clearAllFilters = () => {
  // Nulstil alle tilstande
  selectedPrices.value = [];
  selectedCategory.value = "";
  priceRange.value = { min: 1, max: 1000 };
  activeColors.value = [];
};

watchEffect(() => {
  console.log(selectedPrices.value);
  console.log(filteredProducts.value);
  console.log(colors);
});
</script>

<style scoped>
.thumb {
  max-height: 120px;
  max-width: 100%;
  margin: 0 auto;
}
.chip {
  width: 80px;
  height: 80px;
  margin: 0.3rem;
  border-radius: 50%;
}
.chip:hover {
  cursor: pointer;
}

.bg-black {
  background-color: black;
}
.bg-orange {
  background-color: orange;
}
.bg-indigo {
  background-color: indigo;
}
.bg-gray {
  background-color: gray;
}
.bg-cyan {
  background-color: cyan;
}
.bg-pink {
  background-color: pink;
}

.chip-active {
  opacity: 0.8;
}

.bg-icon {
  display: inline-block;
  width: 100%; /* Juster bredden efter behov */
  height: 100%; /* Juster højden efter behov */
  border-radius: 50%; /* Gør det til en cirkelformet baggrund */
  text-align: center;
  line-height: 80px; /* Centrerer ikonet */
  color: white; /* Farve på ikonet */
  text-shadow: -1px -1px 0 #000, 1px -1px 0 #000, -1px 1px 0 #000,
    1px 1px 0 #000;
}

.clear-all-btn {
  margin-top: 10px;
  background-color: #f44336; /* Rød baggrundsfarve */
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 5px;
  cursor: pointer;
}

.clear-all-btn:hover {
  background-color: #d32f2f; /* Mørkere rød baggrundsfarve ved hover */
}
</style>
