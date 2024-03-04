<template>
  <div>
    <div class="p-fluid pb-4">
      <Chips
        v-model="activeFilters"
        :removable="true"
        @remove="removeFilter($event)"
      ></Chips>
    </div>

    <div class="pb-4">
      <Card>
        <template #content>
          <div class="w-44 slidercard px-4 pt-2 pb-6">
            <p class="pb-2">Pris</p>
            <div class="pb-4">
              <InputText
                v-model.number="priceRange.min"
                class="w-full mb-3 slidercard"
              />
              <Slider
                v-model="priceRange.min"
                class="w-full"
                :max="1000"
                :min="1"
              />
            </div>

            <div>
              <InputText
                v-model.number="priceRange.max"
                class="w-full mb-3 slidercard"
              />
              <Slider
                v-model="priceRange.max"
                class="w-full"
                :max="1000"
                :min="1"
              />
            </div>
          </div>
          <div class="flex gap-5 pt-4">
            <div class="filtercard">Brand (i)</div>
            <div class="filtercard">
              Color (i)
              <!-- Chips for farver -->
              <div
                v-for="color in colors"
                :key="color"
                class="chip"
                :class="{ 'chip-active': activeColors.includes(color) }"
                @click="toggleColor(color)"
              >
                {{ color }}
              </div>
            </div>
            <div class="filtercard">Size (i)</div>
          </div>
        </template>
      </Card>
    </div>

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
    <div v-else>
      <p>No products found.</p>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watchEffect } from "vue";

const selectedPrices = ref([]);
const selectedCategory = ref(""); // men's clothing
const priceRange = ref({ min: 1, max: 1000 }); // Adjust default range as needed

const filteredProducts = computed(() => {
  // Check if any filters are active
  const isFilterActive =
    selectedPrices.value.length > 0 ||
    (priceRange.value.min > 0 && priceRange.value.max < Infinity) ||
    selectedCategory.value !== "";

  if (!isFilterActive) {
    // No filters are active, return all products
    return products.value;
  } else {
    // Filters are active, filter the products
    return products.value.filter(
      (product) =>
        selectedPrices.value.length === 0 &&
        (selectedCategory.value === "" ||
          product.category === selectedCategory.value) &&
        product.price >= priceRange.value.min &&
        product.price <= priceRange.value.max
    );
  }
});

const activeFilters = computed(() => {
  let filters = [];

  if (priceRange.value.min > 0 || priceRange.value.max < Infinity) {
    filters.push(`Price: $${priceRange.value.min} - $${priceRange.value.max}`);
  }

  return filters;
});

function removeFilter(filter) {
  const [key, value] = filter.split(": ");

  switch (key) {
    case "Type":
      selectedType.value = "";
      break;
    case "Price":
      priceRange.value = { min: 0, max: 1000 }; // Reset or adjust according to your logic
      break;
  }
}

const { data: products } = await useAsyncData(() =>
  fetch("https://fakestoreapi.com/products").then((res) => res.json())
);

// Tilføj en ID-egenskab til hvert produktobjekt
products.value.forEach((product, index) => {
  product.id = index + 1; // ID kan være produktets placering i arrayet plus 1 (fordi indeks starter fra 0)
});

const colors = ["Sort", "Grøn", "Blå", "Rød", "Gul"]; // Du kan tilføje flere farver efter behov

// Liste over aktive farver, som brugeren har valgt
const activeColors = ref([]);

// Funktion til at tilføje/fjerne en farve fra listen over aktive farver
const toggleColor = (color) => {
  if (activeColors.value.includes(color)) {
    // Hvis farven allerede er valgt, fjern den
    activeColors.value = activeColors.value.filter((c) => c !== color);
  } else {
    // Ellers tilføj den til listen over aktive farver
    activeColors.value.push(color);
  }
};

watchEffect(() => {
  console.log(selectedPrices.value);
  console.log(filteredProducts.value);
});
</script>

<style scoped>
.thumb {
  max-height: 120px;
  max-width: 100%;
  margin: 0 auto;
}

.chip-active {
  background-color: #ccc; /* Ændre farven efter behov */
}
</style>
