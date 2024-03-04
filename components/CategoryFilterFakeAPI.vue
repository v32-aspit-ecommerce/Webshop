<template>
  <div>
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
                  @remove="removeFilter"
                  class="no-input"
                ></Chips>
              </div>
            </div>
          </div>
          <div class="mt-4" :style="{ display: displayState }">
            <div class="flex gap-5 pt-4">
              <div class="w-1/6 slidercard px-4 pt-2 pb-6">
                <h2 class="filteroverskrift pb-4">Pris</h2>
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

              <div class="filtercard">
                <h2 class="filteroverskrift">Brand - ({{ brandCounts() }})</h2>
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
                    <div class="chipCheck" v-if="activeColors.includes(color)">
                      <i class="pi pi-check"></i>
                    </div>
                    <div class="filterColorText">
                      {{ color }}
                    </div>
                  </div>
                </div>
              </div>
              <div class="filtercard">
                <h2 class="filteroverskrift pb-4">Size</h2>
                <div class="sizeContainer">
                  <div
                    v-for="size in sizesPage1"
                    :key="size"
                    class="size sizePage1"
                    :class="{
                      'chip-active': activeSizes.includes(size),
                    }"
                    @click="toggleSize(size)"
                  >
                    <div class="sizeCheck" v-if="activeSizes.includes(size)">
                      <i class="pi pi-check"></i>
                    </div>
                    <div class="filterSizeText">
                      {{ size }}
                    </div>
                  </div>
                  <div
                    v-for="size in sizesPage2"
                    :key="size"
                    class="size sizePage2 hidden"
                    :class="{
                      'chip-active': activeSizes.includes(size),
                    }"
                    @click="toggleSize(size)"
                  >
                    <div class="sizeCheck" v-if="activeSizes.includes(size)">
                      <i class="pi pi-check"></i>
                    </div>
                    <div class="filterSizeText">
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
// This block of code is used to import specific exports from the 'vue' and 'primeicons' libraries.

// 1. 'ref', 'computed', and 'watchEffect' are imported from 'vue'. These are functions provided by Vue.js for creating reactive references, computed properties, and side effects respectively.
// 2. 'primeicons/primeicons.css' is imported to use the PrimeIcons icon library. This library provides a variety of icons that can be used in the application.

// Importing necessary functions from Vue.js for reactivity
import { ref, computed, watchEffect } from "vue";

// Importing PrimeIcons CSS for using icons in the application
import "primeicons/primeicons.css";

// Testproducts is a placeholder for the products from the API with all the diffrents filters on it
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
    title: "cyan Testprodukt",
    price: 1.99,
    category: "elektronik",
    color: "cyan",
    brand: "alfred",
    size: "28x32",
    image: "https://via.placeholder.com/150",
  },
  {
    id: 4,
    title: "gray Testprodukt",
    price: 99.99,
    category: "elektronik",
    color: "gray",
    brand: "hyper",
    size: "28x34",
    image: "https://via.placeholder.com/150",
  },
  {
    id: 5,
    title: "pink Testprodukt",
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
    title: "orange Testprodukt 2",
    price: 15.99,
    category: "elektronik",
    color: "orange",
    brand: "hyper",
    size: "29x32",
    image: "https://via.placeholder.com/150",
  },
  {
    id: 8,
    title: "cyan Testprodukt 2",
    price: 29.99,
    category: "elektronik",
    color: "cyan",
    brand: "bastion",
    size: "29x34",
    image: "https://via.placeholder.com/150",
  },
  {
    id: 9,
    title: "gray Testprodukt 2",
    price: 199.99,
    category: "elektronik",
    color: "gray",
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

// These are Vue.js reactive references, created using the 'ref' function.
// Reactive references are like single-value reactive objects. When the value they hold changes, Vue.js will automatically update the parts of the application that use these values.

// 1. selectedPrices: A reactive reference to an array that holds the selected prices for filtering products.
// 2. selectedCategory: A reactive reference to a string that holds the selected category for filtering products.
// 3. priceRange: A reactive reference to an object that holds the minimum and maximum price range for filtering products.
// 4. activeFilters: A reactive reference to an array that holds the active filters.
// 5. activeColors: A reactive reference to an array that holds the active colors for filtering products.
// 6. activeSizes: A reactive reference to an array that holds the active sizes for filtering products.
// 7. activeBrands: A reactive reference to an array that holds the active brands for filtering products.

const selectedPrices = ref([]);
const selectedCategory = ref("");
const priceRange = ref({ min: 1, max: 1000 });
const activeFilters = ref([]);
const activeColors = ref([]);
const activeSizes = ref([]);
const activeBrands = ref([]);

// 'computed' is a section in Vue.js where you can define functions that compute data based on other data.
// These functions are known as computed properties.
// Computed properties are reactive, meaning they automatically update when their dependencies change.
// They are also cached, meaning they only recompute when necessary, which can improve performance.
// For example, if you have a 'firstName' and 'lastName' data property, you could create a computed property 'fullName' that combines them.
// If 'firstName' or 'lastName' changes, 'fullName' will automatically update.
// But if they stay the same, 'fullName' will return the cached result, avoiding unnecessary computations.
const filteredProducts = computed(() => {
  const allProducts = [...products.value, ...testProducts.value]; // combines products from API and testProducts to make them to one array

  // 'isFilterActive' is a constant that checks if any filters are active in the application.
  // It does this by checking several conditions and if any of them are true, 'isFilterActive' will be true.
  // Here's what each condition checks:

  // 1. selectedPrices.value.length > 0: Checks if there are any selected prices. If the length is greater than 0, it means there are selected prices.
  // 2. priceRange.value.min > 0 && priceRange.value.max < Infinity: Checks if a price range has been set. If the minimum price is greater than 0 and the maximum price is less than Infinity, it means a price range has been set.
  // 3. selectedCategory.value !== "": Checks if a category has been selected. If the value is not an empty string, it means a category has been selected.
  // 4. activeColors.value.length > 0: Checks if there are any active colors. If the length is greater than 0, it means there are active colors.
  // 5. activeBrands.value.length > 0: Checks if there are any active brands. If the length is greater than 0, it means there are active brands.
  // 6. activeSizes.value.length > 0: Checks if there are any active sizes. If the length is greater than 0, it means there are active sizes.

  // If any of these conditions are true, 'isFilterActive' will be true, indicating that at least one filter is active.
  const isFilterActive =
    selectedPrices.value.length > 0 ||
    (priceRange.value.min > 0 && priceRange.value.max < Infinity) ||
    selectedCategory.value !== "" ||
    activeColors.value.length > 0 ||
    activeBrands.value.length > 0 ||
    activeSizes.value.length > 0;

  // This block of code is used to filter the 'allProducts' array based on various conditions.
  // If no filters are active (i.e., 'isFilterActive' is false), it simply returns all products.

  // If there are active filters, it uses the 'filter' method to create a new array with only the products that meet all the filter conditions.
  // Here's what each condition checks:

  // 1. selectedPrices.value.length === 0 || selectedPrices.value.includes(product.price): If no prices are selected or if the product's price is in the selected prices, the product passes this condition.
  // 2. selectedCategory.value === "" || product.category === selectedCategory.value: If no category is selected or if the product's category matches the selected category, the product passes this condition.
  // 3. priceRange.value.min === 1 || product.price >= priceRange.value.min: If the minimum price range is 1 or if the product's price is greater than or equal to the minimum price range, the product passes this condition.
  // 4. priceRange.value.max === 1000 || product.price <= priceRange.value.max: If the maximum price range is 1000 or if the product's price is less than or equal to the maximum price range, the product passes this condition.
  // 5. activeColors.value.length === 0 || activeColors.value.includes(product.color): If no colors are active or if the product's color is in the active colors, the product passes this condition.
  // 6. activeBrands.value.length === 0 || activeBrands.value.includes(product.brand): If no brands are active or if the product's brand is in the active brands, the product passes this condition.
  // 7. activeSizes.value.length === 0 || activeSizes.value.includes(product.size): If no sizes are active or if the product's size is in the active sizes, the product passes this condition.

  // Only products that pass all conditions are included in the new array, which is then returned.
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

// The 'removeFilter' function is used to remove a specific filter from the active filters.
// It takes one parameter, 'filter', which is the filter to be removed.

// 1. It first finds the index of the filter in the 'activeFilters' array using the 'indexOf' method.
// 2. If the filter is found (i.e., the index is not -1), it removes the filter from the 'activeFilters' array using the 'splice' method.
// 3. Then it checks if the filter is not in the 'colors' array. If it's not, it means the filter is a brand, so it removes the filter from the 'activeBrands' array using the 'filter' method.
// 4. If the filter is in the 'colors' array, it means the filter is a color, so it removes the filter from the 'activeColors' array using the 'filter' method.

// function removeFilter(filter) {
//   const index = activeFilters.value.indexOf(filter);
//   console.log("removeFilter called with:", filter);
//   if (index !== -1) {
//     activeFilters.value.splice(index, 1);
//     if (!colors.includes(filter)) {
//       activeBrands.value = activeBrands.value.filter((b) => b !== filter);
//     } else if (!brands.includes(filter)) {
//       activeColors.value = activeColors.value.filter((c) => c !== filter);
//     } else {
//       activeSizes.value = activeSizes.value.filter((s) => s !== filter);
//     }
//   }
// }

// This block of code is used to fetch product data from a fake online store API and add an 'id' property to each product.

// 1. The 'useAsyncData' function is called with a function that fetches data from "https://fakestoreapi.com/products". This function returns a Promise that resolves with the response of the fetch request.
// 2. The 'then' method is used to parse the response as JSON when the Promise resolves.
// 3. The 'await' keyword is used to pause the execution of the code until the Promise resolves. The resolved value is then destructured to get the 'data' property, which is renamed to 'products'.
// 4. The 'forEach' method is used to loop over each product in the 'products' array. For each product, an 'id' property is added with a value of the product's index in the array plus 1.

// Gets all the products from the API
const { data: products } = await useAsyncData(() =>
  fetch("https://fakestoreapi.com/products").then((res) => res.json())
);

// Add an 'id' property to each product object
products.value.forEach((product, index) => {
  product.id = index + 1;
});

// COLOR SECTION

// 'colors' is an array that holds the color options for filtering products.
// These colors can be selected by the user to filter the products by color.
// The colors available for selection are: "black", "orange", "indigo", "gray", "cyan", and "pink".

// Colors for selection
const colors = ["black", "orange", "indigo", "gray", "cyan", "pink"];

// The 'toggleColor' function is used to add or remove a color from the list of active colors and active filters.
// It takes one parameter, 'color', which is the color to be toggled.

// 1. It first checks if the color is already in the 'activeColors' array using the 'includes' method.
// 2. If the color is found, it removes the color from both the 'activeColors' and 'activeFilters' arrays using the 'filter' method.
// 3. If the color is not found, it adds the color to both the 'activeColors' and 'activeFilters' arrays using the 'push' method.

// Function to add/remove a color from the list of active colors
const toggleColor = (color) => {
  if (activeColors.value.includes(color)) {
    activeColors.value = activeColors.value.filter((c) => c !== color);
    activeFilters.value = activeFilters.value.filter((f) => f !== color);
  } else {
    activeColors.value.push(color);
    activeFilters.value.push(color);
  }
};

// BRAND SECTION

// 'brands' is an array that holds the brand options for filtering products.
// These brands can be selected by the user to filter the products by brand.
// The brands available for selection are: "alfred", "hyper", "bastion", and "Peak".

// Useable brands
const brands = ["alfred", "hyper", "bastion", "Peak"];

// The 'toggleBrand' function is used to add or remove a brand from the list of active brands and active filters.
// It takes one parameter, 'brand', which is the brand to be toggled.

// 1. It first checks if the brand is already in the 'activeBrands' array using the 'includes' method.
// 2. If the brand is found, it removes the brand from both the 'activeBrands' and 'activeFilters' arrays using the 'filter' method.
// 3. If the brand is not found, it adds the brand to both the 'activeBrands' and 'activeFilters' arrays using the 'push' method.

// Function to add/remove a brand from the list of active brands
const toggleBrand = (brand) => {
  if (activeBrands.value.includes(brand)) {
    activeBrands.value = activeBrands.value.filter((b) => b !== brand);
    activeFilters.value = activeFilters.value.filter((f) => f !== brand);
  } else {
    activeBrands.value.push(brand);
    activeFilters.value.push(brand);
  }
};

// SIZE SECTION

// 'sizesPage1' and 'sizesPage2' are arrays that hold the size options for filtering products.
// These sizes can be selected by the user to filter the products by size.
// The sizes are represented as strings in the format "widthxlength".

// Sizes for selection on page 1
const sizesPage1 = [
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
];

// Sizes for selection on page 2
const sizesPage2 = [
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

// The 'toggleSize' function is used to add or remove a size from the list of active sizes and active filters.
// It takes one parameter, 'size', which is the size to be toggled.

// 1. It first checks if the size is already in the 'activeSizes' array using the 'includes' method.
// 2. If the size is found, it removes the size from both the 'activeSizes' and 'activeFilters' arrays using the 'filter' method.
// 3. If the size is not found, it adds the size to both the 'activeSizes' and 'activeFilters' arrays using the 'push' method.

// Function to add/remove a size from the list of active sizes
const toggleSize = (size) => {
  if (activeSizes.value.includes(size)) {
    activeSizes.value = activeSizes.value.filter((c) => c !== size);
    activeFilters.value = activeFilters.value.filter((f) => f !== size);
  } else {
    activeSizes.value.push(size);
    activeFilters.value.push(size);
  }
};

// The 'clearAllFilters' function is used to clear all active filters.
// It does this by resetting the values of all the reactive references that hold the filter states.

// 1. selectedPrices.value = []: Resets the selected prices to an empty array.
// 2. selectedCategory.value = "": Resets the selected category to an empty string.
// 3. priceRange.value = { min: 1, max: 1000 }: Resets the price range to its default values.
// 4. activeColors.value = []: Resets the active colors to an empty array.
// 5. activeBrands.value = []: Resets the active brands to an empty array.
// 6. activeSizes.value = []: Resets the active sizes to an empty array.
// 7. activeFilters.value = []: Resets the active filters to an empty array.

// Method to clear all active filters
const clearAllFilters = () => {
  // Reset all states
  selectedPrices.value = [];
  selectedCategory.value = "";
  priceRange.value = { min: 1, max: 1000 };
  activeColors.value = [];
  activeBrands.value = [];
  activeSizes.value = [];
  activeFilters.value = [];
};

// 'displayState' is a Vue.js reactive reference, created using the 'ref' function.
// It's used to control the display state of a certain element in the application.
// It's initially set to "none", which means the element is not displayed by default.

// Used to give it a default state to be none
const displayState = ref("none");

// The 'toggleDisplay' function is used to toggle the display state of a certain element in the application.
// It does this by changing the value of the 'displayState' reactive reference.

// 1. It checks if the current value of 'displayState' is "none" using the '===' operator.
// 2. If the value is "none", it changes the value to "block". This means the element will be displayed as a block, making it visible.
// 3. If the value is not "none" (i.e., it's "block"), it changes the value back to "none". This means the element will not be displayed, making it hidden.
// 4. This is done using the ternary operator ('?'), which is a shorthand way of writing an if-else statement.

// Used to toggle between open or close the filter
const toggleDisplay = () => {
  displayState.value = displayState.value === "none" ? "block" : "none";
};

// The 'brandCount' function is used to count the number of products for a specific brand.
// It takes one parameter, 'brand', which is the brand to count the products for.

// 1. It uses the 'filter' method to create a new array with only the products that have the specified brand. It does this by checking if the 'brand' property of each product is equal to the specified brand.
// 2. It then gets the length of this new array, which is the number of products for the specified brand.
// 3. This number is returned by the function.

// Function to count the number of products for each brand
const brandCount = (brand) =>
  filteredProducts.value.filter((product) => product.brand === brand).length;

// The 'brandCounts' function is used to calculate the total number of products across all brands.
// It does this by mapping over the 'brands' array and calling the 'brandCount' function for each brand.

// 1. The 'map' method is used to create a new array with the number of products for each brand. It does this by calling the 'brandCount' function with each brand.
// 2. The 'reduce' method is then used to sum up these numbers to get the total number of products. It does this by adding up each number in the array, starting from 0.
// 3. This total number is returned by the function.

// Function to calculate the total number of brands
const brandCounts = () =>
  brands.map((brand) => brandCount(brand)).reduce((a, b) => a + b, 0);

// This block of code is a Vue.js 'watchEffect' function.
// 'watchEffect' is used to perform side effects in response to reactive dependencies changing.

// In this case, the side effect is logging the current values of 'selectedPrices.value', 'filteredProducts.value', and 'colors' to the console.
// Whenever any of these reactive dependencies change, the function will be run again, logging the new values.

// Watch for changes in selectedPrices, filteredProducts, and colors
watchEffect(() => {
  console.log(selectedPrices.value); // Log the current selected prices
  console.log(filteredProducts.value); // Log the current filtered products
  console.log(colors); // Log the current colors
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

.chipCheck {
  position: absolute;
  display: inline-block;
  width: 100%;
  height: 100%;
  border-radius: 50%;
  text-align: center;
  line-height: 50px;
  color: white;

  /* border: 2px solid hsl(164, 82%, 39%); */

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

/* FILTER SIZE */
.sizeContainer {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
  gap: 0.6rem;
}
.size {
  position: relative;
  width: calc(25% - 0.6rem);
  background-color: lightgray;
  border-radius: 5px;
  padding: 0.8rem 0;
}
.filterSizeText {
  text-align: center;
}
.sizeCheck {
  /* position: absolute;
  display: inline-block;
  width: 100%;
  height: 100%;
  border-radius: 50%;
  text-align: center;
  color: white; */

  position: absolute;
  width: 100%;
  border-radius: 5px;
  padding: 0.7rem 0;
  transform: translateY(calc(-0.7rem - 2px));
  border: 2px solid hsl(164, 82%, 39%);
}
.sizeCheck i {
  opacity: 0;
}

.p-chips-input-token {
  display: none;
}
.no-input li > input {
  display: none;
}
</style>
