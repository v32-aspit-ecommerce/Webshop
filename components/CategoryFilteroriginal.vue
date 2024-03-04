<template>
  <div class="card p-fluid">
    <Chips
      v-model="activeFilters"
      :removable="true"
      @remove="removeFilter($event)"
    ></Chips>
  </div>

  <div class="card">
    <Card>
      <template #title>Pris</template>
      <template #content>
        <input type="number" v-model="priceRange.min" placeholder="Min Price" />
        <input type="number" v-model="priceRange.max" placeholder="Max Price" />
      </template>
    </Card>
  </div>
  <pre>
        {{ filteredProducts }}
    </pre
  >
</template>

<script setup>
const selectedPrices = ref([]);
const selectedCategory = ref("men's clothing");
const priceRange = ref({ min: 0, max: 1000 }); // Adjust default range as needed

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

watchEffect(() => {
  console.log(selectedPrices.value);
  console.log(filteredProducts.value);
  console.log(data.value);
  console.log(products.value);
});
</script>
