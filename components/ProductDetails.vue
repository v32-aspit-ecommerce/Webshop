<template>
  <div class="card">
    <div class="grid grid-cols-2 gap-10">
      <div class="p-7">
        <img :src="product.image" alt="product image" class="mx-auto my-7" />
      </div>
      <div class="p-7">
        <h2 class="text-4xl my-7">{{ product.title }}</h2>
        <p class="text-xl my-7">Price - ${{ product.price }}</p>
        <h3 class="font-bold border-b-2 mb-4 pb-2">product description:</h3>
        <p class="mb-7">{{ product.description }}</p>

        <!-- <NuxtLink
          :to="`/products/`"
          class="btn"
          @click="
            addToCart(product);
            visibleRight = true;
          "
        >
          <i class="material-icons mr-2 pi pi-shopping-cart"></i>Add to Cart
        </NuxtLink> -->
        <button
          class="btn"
          @click="
            addToCart(product);
            visibleRight = true;
          "
        >
          <i class="material-icons mr-2 pi pi-shopping-cart"></i>Add to Cart
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
const visibleRight = useState("showcart");
const cart = useState("shoppingcart", () => {
  return [];
});

function addToCart(product) {
  cart.value.push(product);
  console.log(product);
}

const { product } = defineProps(["product"]);
</script>

<style scoped>
img {
  max-width: 400px;
}
</style>
