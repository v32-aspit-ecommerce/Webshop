<template>
  <div>
    <!-- Kort til filtreringsmuligheder -->
    <div class="pb-4">
      <Card>
        <template #content>
          <div class="flex">
            <button @click="toggleDisplay" class="filter-btn">
              Filter<i class="pi pi-chevron-down"></i>
            </button>
            <div class="mx-2">
              <div class="flex">
                <button @click="clearAllFilters" class="clear-all-btn">
                  Clear Tags
                </button>
                <Chips
                  v-model="activeFilters"
                  :removable="true"
                  @remove="removeFilter($event)"
                ></Chips>
              </div>
            </div>
          </div>
          <div class="mt-4" :style="{ display: displayState }">
            <!-- Chip-komponenten viser aktive filtre -->
            <!-- Slider til priser -->

            <!-- Filtrering efter farver -->
            <div class="flex gap-5 pt-4">
              <div class="w-1/6 slidercard px-4 pt-2 pb-6">
                <h2 class="filteroverskrift pb-4">Pris</h2>
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

              <div class="filtercard">
                <h2 class="filteroverskrift">Brand - ({{ brandCounts() }})</h2>
                <!-- Chips for brands -->
                <div class="flex flex-col">
                  <div
                    v-for="brand in brands"
                    :key="brand"
                    class="brand"
                    :class="{
                      'brand-active': activeBrands.includes(brand),
                    }"
                  >
                    <input
                      type="checkbox"
                      :id="brand"
                      v-model="activeBrands"
                      :value="brand"
                    />
                    <label :for="brand" class="brandlabel">
                      <div>{{ brand }}</div>
                      <div class="brandcount">
                        <p class="brandcounttext">{{ brandCount(brand) }}</p>
                      </div>
                    </label>
                  </div>
                </div>
              </div>

              <div class="filtercard">
                <h2 class="filteroverskrift">
                  Color - ({{ activeColors.length }})
                </h2>
                <!-- Chips for farver -->
                <div class="flex flex-wrap justify-between">
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
                    <div class="filterColorText">
                      {{ color }}
                    </div>
                  </div>
                </div>
              </div>
              <div class="filtercard">
                <h2 class="filteroverskrift">Size</h2>
                <div class="flex flex-wrap justify-between">
                  <div
                    v-for="size in sizes"
                    :key="size"
                    class="size"
                    :class="{
                      'chip-active': activeSizes.includes(size),
                    }"
                    @click="toggleSize(size)"
                  >
                    <div class="bg-icon" v-if="activeSizes.includes(size)">
                      <i class="pi pi-check"></i>
                    </div>
                    <div class="filterColorText">
                      {{ size }}
                    </div>
                  </div>
                </div>
              </div>
            </div>
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

// Testprodukter
const testProducts = ref([
  {
    id: 1,
    title: "black Testprodukt",
    price: 25.99,
    category: "elektronik",
    color: "black",
    brand: "hyper",
    size: "28x28",
    image: "https://via.placeholder.com/150",
  },
  {
    id: 2,
    title: "Orange Testprodukt",
    price: 258.99,
    category: "elektronik",
    color: "orange",
    brand: "bastion",
    size: "28x30",
    image: "https://via.placeholder.com/150",
  },
  {
    id: 3,
    title: "Blå Testprodukt",
    price: 1.99,
    category: "elektronik",
    color: "blå",
    brand: "alfred",
    size: "28x32",
    image: "https://via.placeholder.com/150",
  },
  {
    id: 4,
    title: "Grå Testprodukt",
    price: 99.99,
    category: "elektronik",
    color: "grå",
    brand: "hyper",
    size: "28x34",
    image: "https://via.placeholder.com/150",
  },
  {
    id: 5,
    title: "Pink Testprodukt",
    price: 49.99,
    category: "elektronik",
    color: "pink",
    brand: "bastion",
    size: "29x28",
    image: "https://via.placeholder.com/150",
  },
  {
    id: 6,
    title: "black Testprodukt 2",
    price: 59.99,
    category: "elektronik",
    color: "black",
    brand: "alfred",
    size: "29x30",
    image: "https://via.placeholder.com/150",
  },
  {
    id: 7,
    title: "Orange Testprodukt 2",
    price: 15.99,
    category: "elektronik",
    color: "orange",
    brand: "hyper",
    size: "29x32",
    image: "https://via.placeholder.com/150",
  },
  {
    id: 8,
    title: "Blå Testprodukt 2",
    price: 29.99,
    category: "elektronik",
    color: "blå",
    brand: "bastion",
    size: "29x34",
    image: "https://via.placeholder.com/150",
  },
  {
    id: 9,
    title: "Grå Testprodukt 2",
    price: 199.99,
    category: "elektronik",
    color: "grå",
    brand: "alfred",
    size: "30x28",
    image: "https://via.placeholder.com/150",
  },
  {
    id: 10,
    title: "Pink Testprodukt 2",
    price: 5.99,
    category: "elektronik",
    color: "pink",
    brand: "hyper",
    size: "30x30",
    image: "https://via.placeholder.com/150",
  },
]);

// Refs til forskellige filtre og data
const selectedPrices = ref([]);
const selectedCategory = ref("");
const priceRange = ref({ min: 1, max: 1000 });
const activeFilters = ref([]);
const activeColors = ref([]);
const activeSizes = ref([]);
const activeBrands = ref([]);

// Beregning af filtrerede produkter
const filteredProducts = computed(() => {
  const allProducts = [...products.value, ...testProducts.value];

  const isFilterActive =
    selectedPrices.value.length > 0 ||
    (priceRange.value.min > 0 && priceRange.value.max < Infinity) ||
    selectedCategory.value !== "" ||
    activeColors.value.length > 0 ||
    activeBrands.value.length > 0 ||
    activeSizes.value.length > 0;

  if (!isFilterActive) {
    return allProducts;
  } else {
    return allProducts.filter(
      (product) =>
        (selectedPrices.value.length === 0 ||
          selectedPrices.value.includes(product.price)) &&
        (selectedCategory.value === "" ||
          product.category === selectedCategory.value) &&
        (priceRange.value.min === 1 || product.price >= priceRange.value.min) &&
        (priceRange.value.max === 1000 ||
          product.price <= priceRange.value.max) &&
        (activeColors.value.length === 0 ||
          activeColors.value.includes(product.color)) &&
        (activeBrands.value.length === 0 ||
          activeBrands.value.includes(product.brand)) &&
        (activeSizes.value.length === 0 ||
          activeSizes.value.includes(product.size))
    );
  }
});

// Fjernelse af filter
function removeFilter(filter) {
  const index = activeFilters.value.indexOf(filter);
  if (index !== -1) {
    activeFilters.value.splice(index, 1);
    if (!colors.includes(filter)) {
      activeBrands.value = activeBrands.value.filter((b) => b !== filter);
    } else {
      activeColors.value = activeColors.value.filter((c) => c !== filter);
    }
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

// Brands til valg
const brands = ["alfred", "hyper", "bastion", "Peak"];

// Funktion til at tilføje/fjerne et brand fra listen over aktive brands
const toggleBrand = (brand) => {
  if (activeBrands.value.includes(brand)) {
    activeBrands.value = activeBrands.value.filter((b) => b !== brand);
    activeFilters.value = activeFilters.value.filter((f) => f !== brand);
  } else {
    activeBrands.value.push(brand);
    activeFilters.value.push(brand);
  }
};

// Størrelser til valg
const sizes = [
  "28x28",
  "28x30",
  "28x32",
  "28x34",
  "29x28",
  "29x30",
  "29x32",
  "29x34",
  "30x28",
  "30x30",
  "30x32",
  "30x34",
  "31x28",
  "31x30",
  "31x32",
  "31x34",
  "32x28",
  "32x30",
  "32x32",
  "32x34",
  "33x28",
  "33x30",
  "33x32",
  "33x34",
];

// Funktion til at tilføje/fjerne en størrelse fra listen over aktive størrelser
const toggleSize = (size) => {
  if (activeSizes.value.includes(size)) {
    activeSizes.value = activeSizes.value.filter((c) => c !== size);
    activeFilters.value = activeFilters.value.filter((f) => f !== size);
  } else {
    activeSizes.value.push(size);
    activeFilters.value.push(size);
  }
};

// Metode til at fjerne alle aktive filtre
const clearAllFilters = () => {
  // Nulstil alle tilstande
  selectedPrices.value = [];
  selectedCategory.value = "";
  priceRange.value = { min: 1, max: 1000 };
  activeColors.value = [];
  activeBrands.value = [];
  activeSizes.value = [];
  activeFilters.value = [];
};

// Ref til at styre display-tilstanden
const displayState = ref("block");

// Funktion til at skifte display-tilstand mellem 'block' og 'none'
const toggleDisplay = () => {
  displayState.value = displayState.value === "block" ? "none" : "block";
};

// Funktion til at tælle antallet af produkter for hver brand
const brandCount = (brand) =>
  filteredProducts.value.filter((product) => product.brand === brand).length;

// Funktion til at beregne det samlede antal brands
const brandCounts = () =>
  brands.map((brand) => brandCount(brand)).reduce((a, b) => a + b, 0);

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
  position: relative;
  width: 50px;
  height: 50px;
  margin: 1rem 2rem;
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
}

.bg-icon {
  position: absolute;
  display: inline-block;
  width: 100%;
  height: 100%;
  border-radius: 50%;
  text-align: center;
  line-height: 50px;
  color: white;
  /* text-shadow: -1px -1px 0 #000, 1px -1px 0 #000, -1px 1px 0 #000,
    1px 1px 0 #000; */
}

.clear-all-btn {
  background-color: #f44336; /* Rød baggrundsfarve */
  color: white;
  border: none;
  padding: 10px 20px;
  margin-right: 0.7rem;
  border-radius: 5px;
  cursor: pointer;
}

.clear-all-btn:hover {
  background-color: #d32f2f; /* Mørkere rød baggrundsfarve ved hover */
}

.filter-btn {
  display: flex;
  align-items: center;
  background-color: hsl(164, 82%, 39%); /* Rød baggrundsfarve */
  color: white;
  padding: 10px 20px;
  border-radius: 5px;
  cursor: pointer;
}
.filter-btn i {
  margin-left: 0.5rem;
}

.brand {
  display: flex;
  padding-top: 0.7rem;
}
.brandlabel {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  padding-left: 0.7rem;
  line-height: 25px;
}
.brandcount {
  background-color: lightgray;
  border-radius: 50%;
  width: 25px;
  height: 25px;
}
.brandcounttext {
  display: inline-block;
  width: 100%; /* Juster bredden efter behov */
  height: 100%; /* Juster højden efter behov */
  border-radius: 50%; /* Gør det til en cirkelformet baggrund */
  text-align: center;
  line-height: 25px; /* Centrerer ikonet */
  color: black; /* Farve på ikonet */
  font-weight: bold;
}

.filteroverskrift {
  font-weight: 500;
  color: hsl(164, 82%, 39%);
  font-weight: bold;
}
.filterColorText {
  text-align: center;
  margin-top: 50px;
  position: relative;
}
</style>
