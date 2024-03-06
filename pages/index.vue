<script setup>
const { data: products, pending, error } = await useFetch('/api/products')

const reloadProducts = async () => {
  pending.value = true
  error.value = null
  try {
    const response = await $fetch('/api/products')
    const data = await response
    products.value = data
    pending.value = false
  } catch (err) {
    error.value = err
    pending.value = false
  }
}
</script>

<template>
  <div class="p-2 md:p-6 lg:p-10">
    <Button @click="reloadProducts" label="Reload products"  class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 me-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800" />
  
    <!-- Når produkter er ved at loade -->
    <!-- Her er det godt at bruge et skeleton component -->
    <!-- https://tailwind.primevue.org/skeleton/ -->
    <div v-if="pending">Loading...</div>
    <div v-else-if="error">Error loading products.</div>

    <!-- Produkter hvis de loades -->
    <div v-else class="flex flex-wrap gap-6 ">
      <article  v-for="product in products.products" :key="product.id" class="bg-white rounded-lg overflow-hidden shadow-md max-w-sm">
        <img class="w-full" :src="product.thumbnail">
        <div class="p-4">
            <h3 class="text-lg font-medium mb-2">
              {{ product.title }}
            </h3>
            <p class="text-gray-600 text-sm mb-4">
              {{ product.description }}
            </p>
        </div>
      </article>
    </div>


    <pre>
      {{ products.products }}
    </pre>


  </div>
</template>